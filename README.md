# Financial Transaction API

A comprehensive RESTful API for managing financial transactions built with Python, FastAPI, PostgreSQL and  Docker

## Features

- ✅ Full CRUD operations for financial transactions
- ✅ Transaction filtering and pagination
- ✅ Transaction statistics and summaries
- ✅ PostgreSQL database with SQLAlchemy ORM
- ✅ Database migrations with Alembic
- ✅ Docker containerization
- ✅ AWS S3 integration for file storage
- ✅ RESTful API with OpenAPI documentation
- ✅ Type-safe with Pydantic models

## Tech Stack

- **Python 3.11+**
- **FastAPI** - Modern, fast web framework
- **PostgreSQL** - Relational database
- **SQLAlchemy** - ORM for database operations
- **Alembic** - Database migration tool
- **Docker & Docker Compose** - Containerization
- **AWS S3** - File storage service
- **Pydantic** - Data validation

## Project Structure

```
financial_transaction_API/
├── app/
│   ├── __init__.py
│   ├── main.py                 # FastAPI application entry point
│   ├── api/
│   │   └── v1/
│   │       ├── router.py       # API router
│   │       └── endpoints/
│   │           └── transactions.py  # Transaction endpoints
│   ├── core/
│   │   ├── config.py           # Application configuration
│   │   └── database.py         # Database connection
│   ├── models/
│   │   └── transaction.py      # SQLAlchemy models
│   ├── schemas/
│   │   └── transaction.py      # Pydantic schemas
│   └── services/
│       └── aws_service.py       # AWS S3 service
├── alembic/                     # Database migrations
├── docker-compose.yml          # Docker Compose configuration
├── Dockerfile                  # Docker image definition
├── requirements.txt            # Python dependencies
└── README.md                   # This file
```

## Prerequisites

- Docker and Docker Compose installed
- Python 3.11+ (for local development)

## Quick Start with Docker

1. **Clone the repository** (if applicable) or navigate to the project directory

2. **Create a `.env` file** from the example:

   ```bash
   cp .env.example .env
   ```

3. **Update `.env` file** with your configuration:

   ```env
   DATABASE_URL=postgresql://postgres:postgres@db:5432/financial_db
   SECRET_KEY=your-secret-key-here
   AWS_ACCESS_KEY_ID=your-aws-access-key
   AWS_SECRET_ACCESS_KEY=your-aws-secret-key
   AWS_REGION=us-east-1
   AWS_S3_BUCKET_NAME=your-bucket-name
   ```

4. **Start the services**:

   ```bash
   docker-compose up -d
   ```

5. **Run database migrations**:

   ```bash
   docker-compose exec api alembic upgrade head
   ```

6. **Access the API**:
   - API: http://localhost:8000
   - Interactive API docs: http://localhost:8000/docs
   - ReDoc: http://localhost:8000/redoc

## Local Development Setup

1. **Create a virtual environment**:

   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies**:

   ```bash
   pip install -r requirements.txt
   ```

3. **Set up PostgreSQL database**:

   - Install PostgreSQL locally or use Docker:
     ```bash
     docker run --name postgres_db -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=financial_db -p 5432:5432 -d postgres:15-alpine
     ```

4. **Create `.env` file** with your local database URL:

   ```env
   DATABASE_URL=postgresql://postgres:postgres@localhost:5432/financial_db
   SECRET_KEY=your-secret-key-here
   ```

5. **Run database migrations**:

   ```bash
   alembic upgrade head
   ```

6. **Start the development server**:
   ```bash
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```

## Database Migrations

### Create a new migration:

```bash
alembic revision --autogenerate -m "Description of changes"
```

### Apply migrations:

```bash
alembic upgrade head
```

### Rollback migration:

```bash
alembic downgrade -1
```

## API Endpoints

### Transactions

- `POST /api/v1/transactions/` - Create a new transaction
- `GET /api/v1/transactions/` - List all transactions (with pagination and filters)
- `GET /api/v1/transactions/{id}` - Get a specific transaction
- `PUT /api/v1/transactions/{id}` - Update a transaction
- `DELETE /api/v1/transactions/{id}` - Delete a transaction
- `GET /api/v1/transactions/stats/summary` - Get transaction statistics

### Query Parameters for List Transactions

- `page` - Page number (default: 1)
- `page_size` - Items per page (default: 10, max: 100)
- `transaction_type` - Filter by type: `income`, `expense`, `transfer`
- `status` - Filter by status: `pending`, `completed`, `failed`, `cancelled`
- `category` - Filter by category string

## Example API Usage

### Create a Transaction

```bash
curl -X POST "http://localhost:8000/api/v1/transactions/" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 1000.50,
    "currency": "USD",
    "transaction_type": "income",
    "description": "Salary payment",
    "category": "Salary",
    "from_account": "Company ABC",
    "to_account": "My Account"
  }'
```

### List Transactions

```bash
curl "http://localhost:8000/api/v1/transactions/?page=1&page_size=10&transaction_type=income"
```

### Get Transaction Statistics

```bash
curl "http://localhost:8000/api/v1/transactions/stats/summary"
```

## Transaction Model

- **id**: Unique identifier
- **amount**: Transaction amount (positive number)
- **currency**: Currency code (ISO 4217, default: USD)
- **transaction_type**: `income`, `expense`, or `transfer`
- **status**: `pending`, `completed`, `failed`, or `cancelled`
- **description**: Transaction description
- **category**: Transaction category
- **from_account**: Source account
- **to_account**: Destination account
- **reference_number**: Unique reference number (auto-generated if not provided)
- **metadata**: Additional JSON data
- **created_at**: Timestamp of creation
- **updated_at**: Timestamp of last update

## AWS Integration

The API includes AWS S3 integration for file storage. To use it:

1. Configure AWS credentials in `.env`:

   ```env
   AWS_ACCESS_KEY_ID=your-access-key
   AWS_SECRET_ACCESS_KEY=your-secret-key
   AWS_REGION=us-east-1
   AWS_S3_BUCKET_NAME=your-bucket-name
   ```

2. The AWS service is available in `app/services/aws_service.py` and can be used to:
   - Upload files to S3
   - Download files from S3
   - Delete files from S3

## Testing

You can test the API using the interactive documentation at `/docs` or using tools like `curl` or Postman.

## Production Deployment

### AWS Deployment Considerations

1. **Database**: Consider using AWS RDS for PostgreSQL
2. **Application**: Deploy to AWS ECS, EKS, or EC2
3. **Load Balancer**: Use AWS Application Load Balancer
4. **Secrets**: Use AWS Secrets Manager for sensitive configuration
5. **Monitoring**: Set up CloudWatch for logging and monitoring

### Environment Variables for Production

Make sure to set secure values for:

- `SECRET_KEY` - Use a strong, random secret key
- `DATABASE_URL` - Use a secure database connection string
- `DEBUG` - Set to `False` in production
- AWS credentials - Use IAM roles when possible

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is open source and available under the MIT License.

## Support

For issues and questions, please open an issue in the repository.
