{% include "Includes/Header.stencil" %}

import Foundation

extension Request where T == {{ successType|default:"NoResponseBody"}} {

    /**
        {% if summary %}{% if summary != description %}{{ summary }}{% else %}Description forthcoming.{% endif %}

        {% endif %}
        {% if description %}
        {{ description }}

        {% endif %}
        {%if tag %}
        Docs: {%if tag == "sandbox" %}https://dev.soracom.io/jp/docs/api_sandbox/#!/{% else %}https://dev.soracom.io/en/docs/api/#!/{% endif %}{{ tag }}/{{ operationId }}{% endif %}
    */
    public class func {{ operationId }}(
        {% if bodyParam %}{{ bodyParam.name}}: {{ bodyParam.type }}, {% endif %}
        {% for param in nonBodyParams %}
        {{param.name}}: {{param.optionalType}}{% ifnot param.required %} = nil{% endif %},
{% endfor %}
        responseHandler: ResponseHandler<{{ successType|default:"NoResponseBody"}}>? = nil
    ) ->   Request<{{ successType|default:"NoResponseBody"}}> {

        let path  = "{{ pathWithPlaceholdersConvertedToSwiftStringLiteralWithInterpolation }}"

        let requestObject = Request<{{ successType|default:"NoResponseBody"}}>.init(path, responseHandler: responseHandler)

        {% if bodyParam %}requestObject.messageBody = {{ bodyParam.name}}.toData(){% endif %}
        requestObject.expectedHTTPStatus = {{ responses.first.statusCode }}
        requestObject.method = .{{ method|lowercase }}{% if not securityRequirements %}
        requestObject.shouldSendAPIKeyAndTokenInHTTPHeaders = false{% endif %}

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
