#!/bin/bash

echo "------------- Getting test scripts files and dependencies --------"
python3 -m pip install --user virtualenv
# shellcheck disable=SC1091
python3 -m venv env && source env/bin/activate && pip install -r requirements.txt
echo "-------------- Running unit tests before deployment ------------------"
#coverage run --omit 'env/**/*' -m pytest -rp && coverage report -m
#coverage run --omit 'env/**/*' -m pytest -rp
coverage run --omit 'env/**/*' -m pytest -rp && coverage report -m
coverage json --fail-under=50
ls
#x=$(coverage report --fail-under=70)
coverage_file=coverage.json
coverage_percentage=$(jq .totals.percent_covered_display $coverage_file)
echo "$coverage_percentage"
if [ "$coverage_percentage" < "81" ]; then
    echo "GOOD ###############################"
else
    echo "Exiting"
    exit 1
fi
deactivate
echo "-------------- Unit tests finished -----------------"
echo "-------------- Starting to deploy ------------------"
