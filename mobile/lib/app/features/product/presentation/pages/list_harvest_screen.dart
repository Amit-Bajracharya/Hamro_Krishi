import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/core/services/location_service.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/bloc/product_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';

class ListHarvestScreen extends StatefulWidget {
  const ListHarvestScreen({super.key});

  @override
  State<ListHarvestScreen> createState() => _ListHarvestScreenState();
}

class _ListHarvestScreenState extends State<ListHarvestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _harvestDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  
  String? _selectedCategory;
  DateTime? _harvestDate;
  DateTime? _expiryDate;
  bool _isFetchingLocation = false;

  final List<String> _categories = ['vegetable', 'fruit', 'grain'];

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      final locationService = GetIt.I<LocationService>();
      final position = await locationService.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _latitudeController.text = position.latitude.toString();
        _longitudeController.text = position.longitude.toString();
        _isFetchingLocation = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isFetchingLocation = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch location automatically: $e')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _harvestDateController.dispose();
    _expiryDateController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isExpiry) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isExpiry ? (_harvestDate ?? now) : now,
      firstDate: isExpiry ? (_harvestDate ?? now) : now,
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2D5A27),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1B3A1A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isExpiry) {
          _expiryDate = picked;
          _expiryDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        } else {
          _harvestDate = picked;
          _harvestDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
          // Reset expiry if it's now before harvest
          if (_expiryDate != null && _expiryDate!.isBefore(_harvestDate!)) {
            _expiryDate = null;
            _expiryDateController.clear();
          }
        }
      });
    }
  }

  void _showImagePickerOptions() {
    final productBloc = context.read<ProductBloc>();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () {
                productBloc.add(const ProductEvent.pickImage(source: ImageSource.gallery));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                productBloc.add(const ProductEvent.pickImage(source: ImageSource.camera));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitListing() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }
    if (_expiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expiry date is required')));
      return;
    }

    // Get Farmer ID from LoginBloc
    final authState = context.read<LoginBloc>().state;
    String? farmerId;
    authState.maybeMap(
      success: (state) => farmerId = state.user.id,
      orElse: () {},
    );

    if (farmerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error: User session not found')));
      return;
    }

    if (_latitudeController.text.isEmpty || _longitudeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Latitude and Longitude are required. Please fetch location.')));
      return;
    }

    final product = ProductEntity(
      name: _nameController.text,
      category: _selectedCategory!,
      harvestDate: _harvestDate,
      expiryDate: _expiryDate!,
      price: double.parse(_priceController.text),
      quantity: double.parse(_quantityController.text),
      farmerId: farmerId,
      latitude: double.parse(_latitudeController.text),
      longitude: double.parse(_longitudeController.text),
    );

    context.read<ProductBloc>().add(ProductEvent.submitHarvest(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        state.maybeMap(
          success: (s) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.message)));
            Navigator.pop(context);
          },
          failure: (f) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(f.error), backgroundColor: Colors.red));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAF7),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1B3A1A)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'List Harvest',
            style: TextStyle(color: const Color(0xFF1B3A1A), fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  _buildImagePickerCard(),
                  SizedBox(height: 24.h),
                  _buildInputCard(
                    label: 'PRODUCT NAME',
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: 'e.g. Organic Red Tomatoes', border: InputBorder.none),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildCategoryCard(),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(child: _buildQuantityCard()),
                      SizedBox(width: 16.w),
                      Expanded(child: _buildPriceCard()),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildDateSection(),
                  SizedBox(height: 16.h),
                  _buildLocationSection(),
                  SizedBox(height: 32.h),
                  _buildSubmitButton(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('FARM LOCATION', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 1.0)),
            if (_isFetchingLocation)
              SizedBox(height: 12.sp, width: 12.sp, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2D5A27)))
            else
              GestureDetector(
                onTap: _fetchLocation,
                child: Text('Refresh', style: TextStyle(fontSize: 12.sp, color: const Color(0xFF2D5A27), fontWeight: FontWeight.bold)),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildInputCard(
                label: 'LATITUDE',
                child: TextFormField(
                  controller: _latitudeController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(hintText: '0.0000', border: InputBorder.none),
                  validator: (v) => v!.isEmpty ? 'Req' : null,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildInputCard(
                label: 'LONGITUDE',
                child: TextFormField(
                  controller: _longitudeController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(hintText: '0.0000', border: InputBorder.none),
                  validator: (v) => v!.isEmpty ? 'Req' : null,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text('Correct coordinates help buyers find you faster.', style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
      ],
    );
  }

  Widget _buildImagePickerCard() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final File? imageFile = state.maybeMap(
          initial: (s) => s.imageFile,
          success: (s) => s.imageFile,
          orElse: () => null,
        );

        return GestureDetector(
          onTap: _showImagePickerOptions,
          child: Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              image: imageFile != null ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover) : null,
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: imageFile == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined, size: 40.sp, color: const Color(0xFF2D5A27)),
                      SizedBox(height: 8.h),
                      Text('Add Product Photo', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                    ],
                  )
                : Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(12.w),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, color: const Color(0xFF2D5A27), size: 20.sp),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard() {
    return _buildInputCard(
      label: 'CATEGORY',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          hint: const Text('Select category'),
          isExpanded: true,
          items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c.toUpperCase()))).toList(),
          onChanged: (v) => setState(() => _selectedCategory = v),
        ),
      ),
    );
  }

  Widget _buildQuantityCard() {
    return _buildInputCard(
      label: 'QUANTITY',
      child: TextFormField(
        controller: _quantityController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: '0.00', suffixText: 'KG', border: InputBorder.none),
        validator: (v) => v!.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildPriceCard() {
    return _buildInputCard(
      label: 'PRICE (PER KG)',
      child: TextFormField(
        controller: _priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: 'NPR', border: InputBorder.none),
        validator: (v) => v!.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildDateSection() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context, false),
            child: _buildInputCard(
              label: 'HARVESTED',
              child: Text(_harvestDateController.text.isEmpty ? 'Pick date' : _harvestDateController.text),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context, true),
            child: _buildInputCard(
              label: 'EXPIRES',
              child: Text(_expiryDateController.text.isEmpty ? 'Pick date' : _expiryDateController.text),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputCard({required String label, required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey[200]!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.grey[500], letterSpacing: 0.5)),
          child,
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);

        return SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : _submitListing,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D5A27),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text('List Your Harvest', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
