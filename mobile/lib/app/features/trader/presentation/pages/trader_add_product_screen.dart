import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hamrokrishi_app/app/core/services/location_service.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';
import 'package:hamrokrishi_app/app/features/trader/presentation/bloc/trader_product_bloc.dart';

class TraderAddProductScreen extends StatefulWidget {
  const TraderAddProductScreen({super.key});

  @override
  State<TraderAddProductScreen> createState() => _TraderAddProductScreenState();
}

class _TraderAddProductScreenState extends State<TraderAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  
  ContractEntity? _selectedContract;
  bool _isFetchingLocation = false;

  @override
  void initState() {
    super.initState();
    _fetchContracts();
    _fetchLocation();
  }

  void _fetchContracts() {
    final loginState = context.read<LoginBloc>().state;
    loginState.maybeMap(
      success: (state) {
        context.read<TraderProductBloc>().add(TraderProductEvent.fetchTraderContracts(traderId: state.user.id));
      },
      orElse: () {},
    );
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch location: $e')));
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _submitProduct() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedContract == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a contract')));
      return;
    }

    final product = TraderProductEntity(
      contractId: _selectedContract!.id!,
      quantityForSale: double.parse(_quantityController.text),
      latitude: double.parse(_latitudeController.text),
      longitude: double.parse(_longitudeController.text),
    );

    context.read<TraderProductBloc>().add(TraderProductEvent.addTraderProduct(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TraderProductBloc, TraderProductState>(
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
            'List Product for Sale',
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
                  _buildContractSection(),
                  SizedBox(height: 24.h),
                  _buildInputCard(
                    label: 'QUANTITY TO LIST',
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(hintText: '0.0', suffixText: 'KG', border: InputBorder.none),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildLocationSection(),
                  SizedBox(height: 48.h),
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

  Widget _buildContractSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT CONTRACT',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 1.0),
        ),
        SizedBox(height: 12.sp),
        BlocBuilder<TraderProductBloc, TraderProductState>(
          builder: (context, state) {
            final List<ContractEntity> contracts = state.maybeWhen(
              loaded: (_, contracts) => contracts,
              loading: () => [],
              orElse: () => [],
            );

            if (contracts.isEmpty && (state is TraderProductLoading)) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFF2D5A27)));
            }

            if (contracts.isEmpty) {
              return _buildInputCard(
                label: 'ERROR',
                child: const Text('No active contracts found to list products from.'),
              );
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ContractEntity>(
                  value: _selectedContract,
                  isExpanded: true,
                  hint: const Text('Select an active contract'),
                  items: contracts.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text('${c.productName ?? 'Product'} (${c.quantity} KG)'),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedContract = v),
                ),
              ),
            );
          },
        ),
        if (_selectedContract != null) ...[
          SizedBox(height: 12.h),
          Text(
            'Price from contract: NPR ${_selectedContract!.traderSellingPrice.toStringAsFixed(0)} / KG',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF2D5A27), fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PICKUP LOCATION', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 1.0)),
            if (_isFetchingLocation)
              SizedBox(height: 12.sp, width: 12.sp, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2D5A27)))
            else
              GestureDetector(
                onTap: _fetchLocation,
                child: Text('Fetch Current', style: TextStyle(fontSize: 12.sp, color: const Color(0xFF2D5A27), fontWeight: FontWeight.bold)),
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
                  validator: (v) => v!.isEmpty ? 'Required' : null,
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
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text('Location where the product is available.', style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
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
    return BlocBuilder<TraderProductBloc, TraderProductState>(
      builder: (context, state) {
        final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);

        return SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : _submitProduct,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D5A27),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text('List Product for Sale', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
