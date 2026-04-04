const { GoogleGenerativeAI } = require('@google/generative-ai');

// Initialize the Gemini API client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

exports.predictDemand = async (req, res) => {
    try {
        const { productName, category, context } = req.query;

        if (!productName) {
            return res.status(400).json({ error: 'productName is required in query parameters' });
        }

        const currentMonth = new Date().toLocaleString('default', { month: 'long' });
        
        const prompt = `You are an expert AI agricultural market analyst in Nepal.
I need a demand prediction for a specific product. Output MUST be valid JSON (do not include markdown wrapping like \`\`\`json).
Here are the details:
- Product Name: ${productName}
- Category: ${category || 'General Agriculture'}
- Current Month: ${currentMonth}
- Additional Context: ${context || 'None'}

Please provide a realistic demand prediction based on seasonality, general market trends for this product, and any given context.
Your response MUST exactly follow this strict JSON format:
{
  "productName": "${productName}",
  "demandLevel": "High" | "Medium" | "Low",
  "estimatedPriceTrend": "Increasing" | "Stable" | "Decreasing",
  "reasoning": "A short, one sentence explanation."
}`;

        const result = await model.generateContent(prompt);
        let text = result.response.text();
        
        // Clean up markdown if the AI includes it despite instructions
        if (text.startsWith('\`\`\`json')) {
            text = text.replace(/^\`\`\`json/m, '').replace(/\`\`\`$/m, '').trim();
        } else if (text.startsWith('\`\`\`')) {
            text = text.replace(/^\`\`\`/m, '').replace(/\`\`\`$/m, '').trim();
        }

        let parsedJson;
        try {
            parsedJson = JSON.parse(text);
        } catch (parseError) {
            console.error('Failed to parse Gemini output:', text);
            return res.status(500).json({ error: 'AI returned invalid formatted response', rawOutput: text });
        }

        res.status(200).json({
            success: true,
            data: parsedJson
        });
    } catch (error) {
        console.error('Error predicting demand:', error);
        res.status(500).json({ error: 'Failed to predict demand', details: error.message });
    }
};
