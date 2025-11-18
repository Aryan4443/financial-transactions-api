# PostgreSQL Connection Details Guide

## Connection Parameters Explained

When setting up PostgreSQL, you'll be asked for these connection details:

### 1. **Server [localhost]:**
- **What it is:** The hostname or IP address where PostgreSQL is running
- **For local development:** `localhost` or `127.0.0.1`
- **For Docker:** `localhost` (if port is exposed) or `db` (if connecting from another container)
- **Recommended value:** `localhost` ✅

### 2. **Database [postgres]:**
- **What it is:** The name of the database you want to connect to
- **Default:** `postgres` (the default administrative database)
- **For this project:** You'll need to create `financial_db` later
- **For initial setup:** Use `postgres` (default) ✅
- **For this project:** `financial_db` (after creation)

### 3. **Port [5432]:**
- **What it is:** The port number PostgreSQL listens on
- **Default:** `5432`
- **Recommended value:** `5432` ✅ (unless you changed it)

### 4. **Username [postgres]:**
- **What it is:** The PostgreSQL user/role name
- **Default:** `postgres` (the superuser account)
- **Recommended value:** `postgres` ✅ (for development)
- **For production:** Create a dedicated user with limited permissions

### 5. **Password for user postgres:**
- **What it is:** The password for the PostgreSQL user
- **For development:** You can set this to `postgres` (simple, matches Docker setup)
- **For production:** Use a strong, secure password
- **Recommended value:** `postgres` ✅ (for development only)

## Recommended Values for This Project

### Initial Setup (Creating Database)
```
Server: localhost
Database: postgres
Port: 5432
Username: postgres
Password: postgres
```

### After Database Creation (For Application)
```
Server: localhost
Database: financial_db
Port: 5432
Username: postgres
Password: postgres
```

## Step-by-Step Setup

### Step 1: Connect to PostgreSQL (Initial Setup)
Use these values to connect:
- **Server:** `localhost`
- **Database:** `postgres` (default database)
- **Port:** `5432`
- **Username:** `postgres`
- **Password:** `postgres` (or whatever you set during installation)

### Step 2: Create the Project Database
Once connected, run:
```sql
CREATE DATABASE financial_db;
```

Or via command line:
```bash
createdb -U postgres financial_db
```

### Step 3: Verify Database Creation
```bash
psql -U postgres -l
```
You should see `financial_db` in the list.

### Step 4: Update Your .env File
Make sure your `.env` file has:
```env
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/financial_db
```

## Connection String Format

The connection details translate to this connection string:
```
postgresql://[username]:[password]@[server]:[port]/[database]
```

Example:
```
postgresql://postgres:postgres@localhost:5432/financial_db
```

Breaking it down:
- `postgresql://` - Protocol
- `postgres` - Username (before the `:`)
- `postgres` - Password (after the `:`)
- `localhost` - Server (after the `@`)
- `5432` - Port (after the `:`)
- `financial_db` - Database (after the `/`)

## Common Scenarios

### Scenario 1: Fresh PostgreSQL Installation
If you just installed PostgreSQL and it's asking for these details:
1. **Server:** `localhost` ✅
2. **Database:** `postgres` ✅ (use default for now)
3. **Port:** `5432` ✅
4. **Username:** `postgres` ✅
5. **Password:** Enter the password you set during installation, or `postgres` if you didn't set one

### Scenario 2: Connecting via psql Command Line
```bash
psql -h localhost -p 5432 -U postgres -d postgres
```
Then enter password when prompted.

### Scenario 3: Using pgAdmin or Other GUI
Enter the same values:
- Host: `localhost`
- Port: `5432`
- Database: `postgres` (or `financial_db` after creation)
- Username: `postgres`
- Password: `postgres` (or your password)

## Security Notes

⚠️ **Important for Production:**
- Don't use `postgres` as password in production
- Create a dedicated database user with limited permissions
- Use strong passwords
- Consider using environment variables or secrets management

For development, `postgres/postgres` is fine, but change it for production!

## Troubleshooting

### "Password authentication failed"
- Check if you're using the correct password
- If you forgot the password, you may need to reset it

### "Connection refused"
- Make sure PostgreSQL service is running
- Check if port 5432 is correct
- Verify PostgreSQL is listening on localhost

### "Database does not exist"
- Connect to `postgres` database first
- Then create `financial_db` using: `CREATE DATABASE financial_db;`

