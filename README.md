# Pull Request Commenter <br />
GitHub action that comments on your pull request if you have you input a variable, it creates or updates a comment in the pull request with the output. It can also fail the workflow based on the output.

## Usage<br />
Include the following in your workflow file:
```yaml
- name: Run Pull Request Commenter
  uses: OrjanSkarnes/pull-request-commenter@<tag/branch>
  with:
    comment-body: <content_for_comment_body>
    comment-search-includes: <text_to_search_for_in_existing_comments>
    comment-title: <title_for_the_comment>
    comment-reactions: <comma_separated_list_of_reactions>
    remove-comment-if-no-output: <true_or_false>
    fail-on-output: <true_or_false>
    gif-search-term: <search_term_for_gif>
    giphy-api-key: <your_giphy_api_key>
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs
Name | Description | Required | Default
---|---|---|-----
comment-body | Content for comment body | Yes	|
comment-search-includes |	The text to search for in existing comments |	Yes	
comment-title	| Title for the comment |	Yes	
comment-reactions | Comma separated list of reactions | No |
remove-comment-if-no-output | Whether to remove the comment if there is no output | No | True
comment-edit-mode | Edit mode for the comment (append or replace) |	No |	replace
fail-on-output |	Whether to fail the workflow if there is a comment body or not | No |	false
gif-search-term | Search term for gif | No |
giphy-api-key | Your giphy api key | No |
github-token | GitHub token | No |

## Example
```yaml
name: Check Translations
on:
  pull_request:
jobs:
  validate_translation_json:
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.9

    - name: Run python script and set environment variable
      run: |
        message="$(python script.py)"
        echo "ERROR=$message" >> $GITHUB_ENV

    - name: Run Python Script Output Commenter
      uses: OrjanSkarnes/pull-request-commenter@<tag/branch>
      with:
        comment-body: ${{ env.ERROR }}
        comment-search-includes: Output from the script
        comment-title: Output from the script
        fail-on-output: true
        github-token: ${{ secrets.GITHUB_TOKEN }}
```
