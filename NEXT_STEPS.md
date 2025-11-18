# Next Steps - Getting Started

Follow these steps in order to get your Financial Transaction API up and running:

## Step 1: Create .env File ✅

Create your environment configuration file:

```bash
cp env.template .env
```

Or create it manually with minimal configuration:

```bash
cat > .env << EOF
DATABASE_URL=postgresql://postgres:postgres@db:5432/financial_db
SECRET_KEY=dev-secret-key-change-in-production
DEBUG=True
APP_NAME=Financial Transaction API
EOF
```

## Step 2: Choose Your Setup Method

### Option A: Docker (Recommended - Easiest) 🐳

**2a. Check Docker is installed:**
```bash
docker --version
docker-compose --version
```

**2b. Build and start services:**
```bash
docker-compose up -d --build
```

**2c. Wait for services to be ready (about 30 seconds), then run migrations:**
```bash
docker-compose exec api alembic upgrade head
```

**2d. Check if services are running:**
```bash
docker-compose ps
```

**2e. View logs (if needed):**
```bash
docker-compose logs -f api
```

### Option B: Local Development 💻

**2a. Create virtual environment:**
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

**2b. Install dependencies:**
```bash
pip install -r requirements.txt
```

**2c. Start PostgreSQL (if not already running):**
```bash
docker run --name postgres_db \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=financial_db \
  -p 5432:5432 \
  -d postgres:15-alpine
```

**2d. Update .env for local development:**
```bash
# Change DATABASE_URL to:
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/financial_db
```

**2e. Run migrations:**
```bash
alembic upgrade head
```

**2f. Start the server:**
```bash
./run.sh
# Or: uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

## Step 3: Verify API is Running ✅

Open your browser and visit:
- **API Documentation:** http://localhost:8000/docs
- **Alternative Docs:** http://localhost:8000/redoc
- **Health Check:** http://localhost:8000/health

You should see the FastAPI interactive documentation.

## Step 4: Test the API 🧪

### Using the Interactive Docs (Easiest)
1. Go to http://localhost:8000/docs
2. Click on `POST /api/v1/transactions/`
3. Click "Try it out"
4. Use this example JSON:
```json
{
  "amount": 1000.50,
  "currency": "USD",
  "transaction_type": "income",
  "description": "Salary payment",
  "category": "Salary",
  "from_account": "Company ABC",
  "to_account": "My Account"
}
```
5. Click "Execute"
6. You should see a 201 response with the created transaction

### Using cURL
```bash
# Create a transaction
curl -X POST "http://localhost:8000/api/v1/transactions/" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 1000.00,
    "currency": "USD",
    "transaction_type": "income",
    "description": "Test transaction",
    "category": "Salary"
  }'

# List all transactions
curl "http://localhost:8000/api/v1/transactions/"

# Get statistics
curl "http://localhost:8000/api/v1/transactions/stats/summary"
```

## Step 5: Create Initial Migration (If Needed)

If you modify the database models later, create a new migration:

```bash
# With Docker:
docker-compose exec api alembic revision --autogenerate -m "Description"

# Local:
alembic revision --autogenerate -m "Description"
```

Then apply it:
```bash
# With Docker:
docker-compose exec api alembic upgrade head

# Local:
alembic upgrade head
```

## Troubleshooting

### "DATABASE_URL is required" error
- Make sure `.env` file exists in the project root
- Check that `DATABASE_URL` is set correctly

### Port 8000 already in use
```bash
# Find what's using the port
lsof -i :8000

# Or change the port in docker-compose.yml
```

### Database connection errors
- **Docker:** Make sure `db` service is running: `docker-compose ps`
- **Local:** Make sure PostgreSQL is running and accessible
- Check your `DATABASE_URL` matches your setup

### Migration errors
```bash
# Reset migrations (careful - this deletes data!)
docker-compose exec api alembic downgrade base
docker-compose exec api alembic upgrade head
```

## What's Next After Setup?

1. **Explore the API:** Use the interactive docs at `/docs`
2. **Add more features:** Extend the transaction model or add new endpoints
3. **Add authentication:** Implement JWT or OAuth2
4. **Add tests:** Create unit and integration tests
5. **Deploy to production:** Set up on AWS, Heroku, or your preferred platform

## Quick Commands Reference

```bash
# Start services (Docker)
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f api

# Run migrations
docker-compose exec api alembic upgrade head

# Access API container shell
docker-compose exec api bash

# Access database
docker-compose exec db psql -U postgres -d financial_db
```

