# Quick Start Guide

## Option 1: Using Docker (Recommended)

### Step 1: Create Environment File
```bash
cat > .env << EOF
DATABASE_URL=postgresql://postgres:postgres@db:5432/financial_db
APP_NAME=Financial Transaction API
DEBUG=True
SECRET_KEY=dev-secret-key-change-in-production
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_REGION=us-east-1
AWS_S3_BUCKET_NAME=
EOF
```

### Step 2: Start Services
```bash
docker-compose up -d
```

### Step 3: Run Migrations
```bash
docker-compose exec api alembic upgrade head
```

### Step 4: Access API
- Open http://localhost:8000/docs in your browser
- Test the API endpoints interactively

## Option 2: Local Development

### Step 1: Install Dependencies
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### Step 2: Start PostgreSQL
```bash
docker run --name postgres_db \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=financial_db \
  -p 5432:5432 \
  -d postgres:15-alpine
```

### Step 3: Create Environment File
```bash
cat > .env << EOF
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/financial_db
SECRET_KEY=dev-secret-key-change-in-production
DEBUG=True
EOF
```

### Step 4: Run Migrations
```bash
alembic upgrade head
```

### Step 5: Start Server
```bash
./run.sh
# Or: uvicorn app.main:app --reload
```

## Test the API

### Create a Transaction
```bash
curl -X POST "http://localhost:8000/api/v1/transactions/" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 1000.00,
    "currency": "USD",
    "transaction_type": "income",
    "description": "Test transaction",
    "category": "Salary"
  }'
```

### List Transactions
```bash
curl "http://localhost:8000/api/v1/transactions/"
```

### Get Statistics
```bash
curl "http://localhost:8000/api/v1/transactions/stats/summary"
```

## Troubleshooting

### Database Connection Issues
- Ensure PostgreSQL is running
- Check DATABASE_URL in .env file
- Verify database credentials

### Port Already in Use
- Change port in docker-compose.yml or use `--port 8001` with uvicorn

### Migration Errors
- Ensure database is created
- Check database connection string
- Try: `alembic downgrade -1` then `alembic upgrade head`

