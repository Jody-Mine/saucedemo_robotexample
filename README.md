# SauceDemo Robot Framework Test Automation

This project implements automated tests for the SauceDemo e-commerce platform using Robot Framework with the robotframework-browser library.

## Prerequisites

- Python 3.8+
- Node.js 16+
- Robot Framework 6.1+
- Browser Library 18.0+

## Installation

1. Clone this repository
2. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Initialize Browser Library:
   ```bash
   rfbrowser init
   ```

## Project Structure

The project follows a structured approach with:
- Keywords organized by page objects
- Test cases grouped by functionality
- Shared resources and configurations
- Data-driven test capabilities

## Running Tests

To run all tests:
```bash
robot -d results tests/
```

To run specific test suite:
```bash
robot -d results tests/ui/authentication/login-validation.robot
```

## Reports

Test reports are generated in the `results` directory after each run:
- `log.html`: Detailed test execution log
- `report.html`: Test results summary
- `output.xml`: Machine-readable results data

## Continuous Integration

This project uses GitHub Actions for continuous integration. The workflow:
1. Triggers on:
   - Push to main branch
   - Pull requests to main branch
   - Manual workflow dispatch

2. Workflow steps:
   - Sets up Python 3.8
   - Sets up Node.js 16
   - Installs project dependencies
   - Runs Robot Framework tests
   - Uploads test results as artifacts
   - Publishes test results to PR/commit

You can view test results:
1. In the GitHub Actions tab
2. As artifacts in each workflow run
3. As annotations in pull requests
4. In the detailed test report attached to each run
