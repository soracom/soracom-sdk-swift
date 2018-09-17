            } else if T.self == {{ type }}.self {
                result = try d.decode({{ type }}.self, from: data) as? T
            } else if T.self == [{{ type }}].self {
                result = try d.decode([{{ type }}].self, from: data) as? T
