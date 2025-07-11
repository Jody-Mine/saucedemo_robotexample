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

Test reports are generated in the `results` directory after each run.
