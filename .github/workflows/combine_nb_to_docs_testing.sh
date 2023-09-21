# IF MOVING ANY IPYNB, MAKE SURE TO RE-SYMLINK. MANY IPYNB REFERENCED HERE LIVE IN OTHER PATHS

rm -rf break.md
rm -rf alltools.ipynb

# Combined notebook flow - will be tested
# IF MOVING ANY IPYNB, MAKE SURE TO RE-SYMLINK. MANY IPYNB REFERENCED HERE LIVE IN OTHER PATHS
nbmerge langchain_quickstart.ipynb logging.ipynb custom_feedback_functions.ipynb >> all_tools.ipynb

# Colab quickstarts
# IF MOVING ANY IPYNB, MAKE SURE TO RE-SYMLINK. MANY IPYNB REFERENCED HERE LIVE IN OTHER PATHS
nbmerge colab_dependencies.ipynb langchain_quickstart.ipynb >> langchain_quickstart_colab.ipynb
nbmerge colab_dependencies.ipynb llama_index_quickstart.ipynb >> llama_index_quickstart_colab.ipynb
nbmerge colab_dependencies.ipynb text2text_quickstart.ipynb >> text2text_quickstart_colab.ipynb

# Create pypi page documentation

cat intro.md > README.md

# Create top level readme from testable code trulens_eval_gh_top_readme.ipynb
printf  "\n\n" >> break.md
cat gh_top_intro.md break.md ../trulens_explain/gh_top_intro.md > TOP_README.md

# Create non-jupyter scripts
jupyter nbconvert --to script langchain_quickstart.ipynb
jupyter nbconvert --to script llama_index_quickstart.ipynb
jupyter nbconvert --to script text2text_quickstart.ipynb
jupyter nbconvert --to script all_tools.ipynb

# gnu sed/gsed needed on mac:
SED=`which -a gsed sed | head -n1`

# Fix nbmerge ids field invalid for ipynb
$SED -i "/id\"\:/d" all_tools.ipynb langchain_quickstart_colab.ipynb llama_index_quickstart_colab.ipynb text2text_quickstart_colab.ipynb

## Remove ipynb JSON calls
$SED -i "/JSON/d" langchain_quickstart.py llama_index_quickstart.py text2text_quickstart.py all_tools.py 
## Replace jupyter display with python print
$SED -i "s/display/print/g" langchain_quickstart.py llama_index_quickstart.py text2text_quickstart.py all_tools.py
## Remove cell metadata
$SED -i "/\# In\[/d" langchain_quickstart.py llama_index_quickstart.py text2text_quickstart.py all_tools.py
## Remove single # lines
$SED -i "/\#$/d" langchain_quickstart.py llama_index_quickstart.py text2text_quickstart.py all_tools.py
## Collapse multiple empty line from sed replacements with a single line
$SED -i -e "/./b" -e ":n" -e "N;s/\\n$//;tn" langchain_quickstart.py llama_index_quickstart.py text2text_quickstart.py all_tools.py

# Move generated files to their end locations
# EVERYTHING BELOW IS LINKED TO DOCUMENTATION OR TESTS; MAKE SURE YOU UPDATE LINKS IF YOU CHANGE
# IF NAMES CHANGED; CHANGE THE LINK NAMES TOO

# Github users will land on these readmes
mv README.md ../../trulens_eval/README.md
mv TOP_README.md ../../README.md

# Links are referenced in intro.md and gh_intro.md
# There are symlinks from ../../trulens_eval/generated_files/ to these scripts for testing
mv *.py ../../trulens_eval/examples/py_script_quickstarts/

# Links are referenced in intro.md and gh_intro.md
# There are symlinks in ../../trulens_eval/tests/docs_notebooks/notebooks_to_test
mv *quickstart_colab.ipynb ../../trulens_eval/examples/colab/quickstarts/

# Trulens tests run off of these files
mv all_tools* ../../trulens_eval/generated_files/