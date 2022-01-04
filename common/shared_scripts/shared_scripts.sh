#!/bin/bash

echo "------------- Getting test scripts files and dependencies --------"
python3 -m pip install --user virtualenv
# shellcheck disable=SC1091
python3 -m venv env && source env/bin/activate && pip install -r requirements.txt
echo "-------------- Running unit tests before deployment ------------------"
coverage run --omit 'env/**/*' -m pytest -rp && coverage report -m
coverage json --fail-under=50
coverage_file=coverage.json

coverag_mark=95
coverage_percentage=$(jq .totals.percent_covered_display $coverage_file)

if [ "$coverage_percentage" < "$coverage_mark" ]; then
    echo "GOOD ###############################"
else
    echo "Unit test coverage is less than $coverage_mark. Failing build"
    exit 1
fi
deactivate
echo "-------------- Unit tests finished -----------------"
echo "-------------- Starting to deploy ------------------"
