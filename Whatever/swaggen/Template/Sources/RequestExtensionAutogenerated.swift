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

    let path = "{{path}}"{% for param in pathParams %}.replacingOccurrences(of: "{" + "{{ param.value }}" + "}", with: "\({{ param.encodedValue }})"){% endfor %}
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

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
