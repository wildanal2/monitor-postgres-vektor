# PostgreSQL Monitoring with Grafana and Prometheus

This project provides a comprehensive monitoring solution for PostgreSQL databases with pgvector support. It includes a complete stack with Prometheus for metrics collection, Grafana for visualization, and PostgreSQL with pg_stat_statements for detailed query performance monitoring.

## Features

- **PostgreSQL 17 with pgvector support**: Vector database capabilities built-in
- **Prometheus**: Metrics collection and storage
- **Grafana**: Dashboard visualization and alerting
- **PostgreSQL Exporter**: PostgreSQL-specific metrics collection
- **cAdvisor**: Container metrics monitoring
- **Node Exporter**: System metrics collection
- **pg_stat_statements integration**: Query performance monitoring
- **Pre-configured dashboard**: Ready-to-use PostgreSQL monitoring dashboard

## Prerequisites

- Docker
- Docker Compose

## Installation and Setup

### 1. Clone the repository

```bash
git clone https://github.com/wildanal2/monitor-postgres-vektor.git
cd monitor-postgres-vektor
```

### 2. Start the monitoring stack

```bash
docker-compose up -d
```

This will start all services:
- PostgreSQL server (port 5430)
- PostgreSQL Exporter (port 9187)
- Prometheus (port 9090)
- Grafana (port 3000)
- cAdvisor (port 8081)
- Node Exporter (port 9100)

### 3. Access the services

- **Grafana**: http://localhost:3000 (username: admin, password: admin)
- **Prometheus**: http://localhost:9090
- **PostgreSQL**: localhost:5430 (database: vectordb, username: postgres, password: example)

## Configuration

### PostgreSQL Configuration

The PostgreSQL instance is configured with:
- pgvector extension enabled for vector operations
- pg_stat_statements extension enabled for query performance monitoring
- Pre-configured resource limits (2 CPUs, 1GB memory)

### Prometheus Configuration

The Prometheus configuration includes scraping jobs for:
- PostgreSQL Exporter
- Node Exporter
- cAdvisor
- Prometheus itself

### Custom Queries

The `queries.yml` file defines custom queries for PostgreSQL monitoring, specifically focusing on pg_stat_statements data to track query performance metrics including:
- Query ID and normalized query text
- Number of calls
- Total execution time
- Mean execution time

## Usage

### 1. Import the Grafana Dashboard

The project includes a pre-configured Grafana dashboard (`PostgreSQL_pg_stat_statements_dashboard.json`). To import:

1. Open Grafana at http://localhost:3000
2. Navigate to "Dashboards" → "Import"
3. Upload the `PostgreSQL_pg_stat_statements_dashboard.json` file
4. The dashboard will display PostgreSQL performance metrics

### 2. Database Connection

Connect to the PostgreSQL database using these credentials:
- Host: localhost
- Port: 5430
- Database: vectordb
- Username: postgres
- Password: example

Example connection string: `postgresql://postgres:example@localhost:5430/vectordb`

### 3. Monitoring PostgreSQL Performance

The system collects metrics from pg_stat_statements, which provides insights into:
- Most frequently executed queries
- Slowest queries by total execution time
- Average execution time per query
- Query resource consumption

## Project Structure

```
monitor-postgres-vektor/
├── docker-compose.yml          # Docker Compose configuration
├── queries.yml                 # Custom PostgreSQL queries for exporter
├── PostgreSQL_pg_stat_statements_dashboard.json  # Grafana dashboard
├── postgres/
│   ├── Dockerfile              # PostgreSQL Docker configuration
│   └── init-scripts.sql        # Initialization scripts
├── monitoring/
│   └── prometheus/
│       └── prometheus.yml      # Prometheus configuration
├── benchmarks/                 # Benchmarking notebooks and scripts
└── README.md                   # This file
```

## Customization

### Adding Custom Queries

To add custom PostgreSQL queries to be monitored:

1. Edit the `queries.yml` file
2. Add your custom query following the existing format
3. Restart the PostgreSQL Exporter service:

```bash
docker-compose restart postgres_exporter
```

### Modifying PostgreSQL Configuration

To change PostgreSQL settings:

1. Modify the `postgres/Dockerfile` or `postgres/init-scripts.sql`
2. Rebuild the PostgreSQL service:

```bash
docker-compose build postgres
docker-compose up -d postgres
```

### Grafana Dashboard Customization

To customize the Grafana dashboard:

1. Access Grafana at http://localhost:3000
2. Navigate to the PostgreSQL dashboard
3. Make changes as needed
4. Export the updated dashboard for persistence

## Benchmarking

The project includes benchmarking capabilities in the `benchmarks/` directory:
- Jupyter notebooks for analysis (`benchmarks/datasets/insert.ipynb`)
- Benchmarking scripts (`benchmarks/scripts/`)

## Troubleshooting

### Service won't start

If services fail to start, check logs with:
```bash
docker-compose logs <service-name>
```

### Grafana dashboard not showing data

1. Verify that all services are running: `docker-compose ps`
2. Check that Prometheus is scraping metrics: http://localhost:9090/targets
3. Ensure the PostgreSQL Exporter is accessible: http://localhost:9187/metrics

### PostgreSQL connection issues

1. Verify PostgreSQL is running: `docker-compose ps postgres`
2. Check that port 5430 is available on your host
3. Verify credentials in `docker-compose.yml`

## Security Considerations

- Default passwords are used for development purposes only
- Change default Grafana credentials in production
- Secure PostgreSQL access in production environments
- Use environment variables for sensitive configuration

## Stopping the Services

To stop all services:
```bash
docker-compose down
```

To stop services and remove volumes (data will be lost):
```bash
docker-compose down -v
```

## License

[Specify your license here]