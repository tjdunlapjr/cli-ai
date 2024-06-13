#!/bin/bash

# API Keys (Replace with your actual keys)
CHATGPT_API_KEY="INSERT_API_KEY"
GEMINI_API_KEY="INSERT_API_KEY"

# Function to query ChatGPT
query_chatgpt() {
  local prompt="$1"
  curl https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $CHATGPT_API_KEY" \
    -d '{
	"model": "gpt-4o",
        "messages": [{"role": "user", "content": "'"$prompt"'"}],
        "temperature": 0.7
      }' | jq -r '.choices[0].message.content'
}

# Function to query Gemini (Adapt based on Gemini API docs)
query_gemini() {
  local prompt="$1"
  # Replace with the actual Gemini API call 
  curl https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$GEMINI_API_KEY \
    -H "Content-Type: application/json" \
    -d '{"contents": [{"role": "user", "parts":[{"text": "'"$prompt"'"}]}]}' \
    | jq -r '.candidates[0].content.parts[0].text'
}

# Main script logic
while true; do
  read -p "Enter your prompt (or 'exit' to quit): " prompt

  if [[ "$prompt" == "exit" ]]; then
    break
  fi

  chatgpt_response=$(query_chatgpt "$prompt")
  gemini_response=$(query_gemini "$prompt")

  echo ""
  echo "ChatGPT Response:"
  echo "$chatgpt_response"
  echo ""

  echo "Gemini Response:"
  echo "$gemini_response"
  echo ""
done

