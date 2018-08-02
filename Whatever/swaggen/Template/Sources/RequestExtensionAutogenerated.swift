{% include "Includes/Header.stencil" %}

import Foundation

extension Request {

    public class func _{{ operationId }}(
        {% if bodyParam %}{{ bodyParam.name}}: {{ bodyParam.type }}, {% endif %}
        {% for param in nonBodyParams %}
        {{param.name}}: {{param.optionalType}}{% ifnot param.required %} = nil{% endif %},
{% endfor %}
        responseHandler: ResponseHandler<{{ successType|default:"NoResponseBody"}}>? = nil
    ) ->   Request<{{ successType|default:"NoResponseBody"}}> {

        let path = "{{path}}"{% for param in pathParams %}.replacingOccurrences(of: "{" + "{{ param.name }}" + "}", with: "\({{ param.encodedValue }})"){% endfor %} // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<{{ successType|default:"NoResponseBody"}}>.init(path, responseHandler: responseHandler)

        {% if bodyParam %}requestObject.messageBody = {{ bodyParam.name}}.toData(){% endif %}
        requestObject.expectedHTTPStatus = {{ responses.first.statusCode }}
        requestObject.method = .{{ method|lowercase }}

        {% if queryParams %}
        requestObject.query = makeQueryDictionary([
        {% for param in queryParams %}
            "{{ param.name }}": {{ param.name }}{% ifnot forloop.last %},{% endif %}
        {% endfor %}
        ])
        {% endif %}

        return requestObject
    }

}
