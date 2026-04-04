const { GoogleGenerativeAI } = require('@google/generative-ai');
require('dotenv').config();

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

async function checkModels() {
  try {
    const list = await fetch(`https://generativelanguage.googleapis.com/v1beta/models?key=${process.env.GEMINI_API_KEY}`);
    const data = await list.json();
    console.log(JSON.stringify(data.models.map(m => m.name), null, 2));
  } catch (error) {
    console.error('Error listing models:', error);
  }
}

checkModels();
