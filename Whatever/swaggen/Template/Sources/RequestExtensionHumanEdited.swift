extension Request where T == {{ successType|default:"NoResponseBody"}} {

    public class func {{ operationId }}(
        {% if bodyParam %}{{ bodyParam.name}}: {{ bodyParam.type }}, {% endif %}
        {% for param in nonBodyParams %}
        {{param.name}}: {{param.optionalType}}{% ifnot param.required %} = nil{% endif %},
{% endfor %}
        responseHandler: ResponseHandler<{{ successType|default:"NoResponseBody"}}>? = nil
    ) ->   Request<{{ successType|default:"NoResponseBody"}}> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _{{ operationId }}({% if bodyParam %}{{ bodyParam.name}}: {{ bodyParam.name }}, {% endif %}{% for param in nonBodyParams %}{{param.name}}: {{param.name}}, {% endfor %} responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_{{ operationId }}()) is not sufficient):

        return req
    }

}