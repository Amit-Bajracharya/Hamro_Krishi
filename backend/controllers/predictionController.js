const { GoogleGenerativeAI } = require('@google/generative-ai');

// Initialize the Gemini API client
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

// Simple in-memory cache to prevent hitting API limits
const predictionCache = new Map();
const CACHE_DURATION_MS = 1000 * 60 * 60 * 24; // Cache for 24 hours

exports.getDashboardPredictions = async (req, res) => {
    try {
        const currentMonth = new Date().toLocaleString('default', { month: 'long', year: 'numeric' });
        
        // Use a single global cache key for the dashboard for the current month
        const cacheKey = `dashboard_prediction_${currentMonth}`.toLowerCase();

        // 1. Check if we already fetched the dashboard data recently
        if (predictionCache.has(cacheKey)) {
            const cachedItem = predictionCache.get(cacheKey);
            
            // If the cache is still valid (less than 24 hours old), return it immediately
            if (Date.now() - cachedItem.timestamp < CACHE_DURATION_MS) {
                console.log(`Returning cached dashboard predictions...`);
                return res.status(200).json({
                    success: true,
                    data: cachedItem.data,
                    cached: true
                });
            } else {
                // Expired, remove it
                predictionCache.delete(cacheKey);
            }
        }

        console.log(`Asking Gemini AI for Dashboard Predictions...`);
        
        const prompt = `You are an expert AI agricultural market analyst in Nepal.
I need a comprehensive dashboard overview of the highest demand crops right now.
The current date is: ${currentMonth}.

Output MUST be exactly valid JSON (do not include markdown wrapping like \`\`\`json).
Please provide the top 5 trending/highest demand items for each of the following 3 categories: "vegetables", "fruits", and "grains".
For each item, give the demand level, estimated price trend, and a short 1-sentence reasoning.

Your response MUST exactly follow this strict JSON format:
{
  "vegetables": [
    {
      "productName": "Tomato",
      "demandLevel": "High",
      "estimatedPriceTrend": "Increasing",
      "reasoning": "A short explanation here."
    }
  ],
  "fruits": [
    {
       "productName": "Apple",
       "demandLevel": "Medium",
       "estimatedPriceTrend": "Stable",
       "reasoning": "A short explanation here."
    }
  ],
  "grains": [
    {
       "productName": "Rice",
       "demandLevel": "High",
       "estimatedPriceTrend": "Increasing",
       "reasoning": "A short explanation here."
    }
  ]
}

Make sure each category array has exactly 5 items.`;

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

        // 2. Save the successful AI response into our cache for future requests!
        predictionCache.set(cacheKey, {
            timestamp: Date.now(),
            data: parsedJson
        });

        res.status(200).json({
            success: true,
            data: parsedJson,
            cached: false
        });
    } catch (error) {
        console.error('Error fetching dashboard prediction:', error);
        res.status(500).json({ error: 'Failed to fetch dashboard prediction', details: error.message });
    }
};
