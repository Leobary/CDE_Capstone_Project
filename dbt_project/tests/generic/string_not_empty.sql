/* This is a generic test that can be applied across all models and columns
     to ensure that a selected column is not empty. */

string_not_empty.sql
{% test string_not_empty(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where TRIM({{ column_name }}) = ''
{% endtest %}