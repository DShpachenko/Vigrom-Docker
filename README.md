# Инструкция по запуску!

1. Добавить хосты: <code>sudo make hosts </code>
2. Поднять контейнеры: <code>make init</code>
3. После необходимо зайти в контейнер <code>make exec.__billing__</code>
4. Далее необходимо запустить супервизор <code>service supervisor start</code> для обработки очередей


# Методы API

Получение баланса:
<pre>
Запрос GET - http://vigrom-billing.local/api/billing/balance/show:
{
    "wallet_id": 241
}
</pre>

Обновление баланса:
<pre>
Запрос POST - http://vigrom-billing.local/api/billing/balance/update
{
    "wallet_id": 241,
    "type": "debit",
    "reason": "refund",
    "currency": "RUB",
    "sum": 69.0341
}
</pre>