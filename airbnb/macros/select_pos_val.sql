{% macro s_pos_val(model,column_name)%}

select * from {{model}} where {{column_nam}} >0
{% endmacro %}