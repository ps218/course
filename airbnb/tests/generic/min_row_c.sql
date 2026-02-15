{% test min_row_c(model,min_rows) %}
{{config(severity = 'warn')}}
select count(*) as c from {{model}} having count(*) < {{min_rows}}
{% endtest %}