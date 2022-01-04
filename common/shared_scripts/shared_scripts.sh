#!/bin/bash

echo "------------- Getting test scripts files and dependencies --------"
python3 -m pip install --user virtualenv
# shellcheck disable=SC1091
python3 -m venv env && source env/bin/activate && pip install -r requirements.txt
echo "-------------- Running unit tests before deployment ------------------"
coverage run --omit 'env/**/*' -m pytest -rp && coverage report -m
coverage json --fail-under=95
coverage_file=coverage.json

coverage_percentage=$(jq .totals.percent_covered_display $coverage_file)
echo "$coverage_percentage"
if [ "$coverage_percentage" > 95 ]; then
    echo "Unit test passed with accepted coverage"
else
    echo "Unit test coverage is less than 95."
    echo "Failing build......."
    exit 1
fi
deactivate
echo "-------------- Unit tests finished -----------------"
echo "-------------- Starting to deploy ------------------"
