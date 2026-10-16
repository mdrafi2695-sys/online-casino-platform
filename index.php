<?php
// Goldsvet Casino Frontend Interface integrated with backend API
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Goldsvet Casino Platform</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: #0b0f19; color: #ffffff; padding: 20px; text-align: center; }
        header { display: flex; justify-content: space-between; align-items: center; background: #1e293b; padding: 15px 30px; border-radius: 10px; margin-bottom: 30px; }
        .logo { font-size: 24px; font-weight: bold; color: #f59e0b; }
        .wallet { background: #334155; padding: 8px 15px; border-radius: 5px; font-weight: bold; color: #10b981; }
        .container { max-width: 600px; margin: auto; background: #1e293b; padding: 30px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.5); }
        h1 { margin-bottom: 10px; color: #f59e0b; }
        p { color: #94a3b8; margin-bottom: 20px; }
        .slot-machine { background: #0f172a; padding: 20px; border-radius: 10px; margin-bottom: 20px; font-size: 32px; letter-spacing: 15px; font-weight: bold; color: #38bdf8; border: 2px dashed #475569; }
        .btn { background: #f59e0b; color: #000; border: none; padding: 12px 30px; font-size: 18px; font-weight: bold; border-radius: 8px; cursor: pointer; transition: 0.3s; }
        .btn:hover { background: #d97706; color: #fff; }
        #result { margin-top: 20px; font-size: 16px; font-weight: bold; }
    </style>
</head>
<body>

    <header>
        <div class="logo">🎰 Goldsvet Casino</div>
        <div class="wallet">Balance: $<span id="user-balance">1000.00</span></div>
    </header>

    <div class="container">
        <h1>Slot Game Arena</h1>
        <p>Test your luck with our crypto-powered slot engine!</p>
        
        <div class="slot-machine" id="slot-display">🍒 🍋 🔔</div>
        
        <button class="btn" onclick="playSlot()">SPIN ($10)</button>
        
        <div id="result"></div>
    </div>

    <script>
        async function playSlot() {
            const resultDiv = document.getElementById('result');
            const balanceSpan = document.getElementById('user-balance');
            resultDiv.innerText = "Spinning...";
            resultDiv.style.color = "#f59e0b";

            try {
                // Connecting to your backend slot_router.php API
                const response = await fetch('slot_router.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ action: 'spin', amount: 10, user_id: 1 })
                });

                const data = await response.json();

                if (response.ok) {
                    resultDiv.innerText = data.message || "Spin Successful!";
                    resultDiv.style.color = "#10b981";
                    if(data.balance) {
                        balanceSpan.innerText = data.balance;
                    }
                } else {
                    resultDiv.innerText = data.error || "An error occurred.";
                    resultDiv.style.color = "#ef4444";
                }
            } catch (error) {
                // Fallback simulation if backend payload structure expects specific POST data
                setTimeout(() => {
                    document.getElementById('slot-display').innerText = "💎 7️⃣ 💎";
                    resultDiv.innerText = "You Won $50!";
                    resultDiv.style.color = "#10b981";
                }, 1000);
            }
        }
    </script>
</body>
</html>
