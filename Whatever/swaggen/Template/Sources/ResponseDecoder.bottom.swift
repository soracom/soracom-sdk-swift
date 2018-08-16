
// --------------------END AUTOGEN

            } else {
                fatalError("FIXME: type not handled: \(T.self)")
            }
        } catch let err {
            Metrics.record(type: .decodeFailure, description: "\(self).parse() failed", error: err, data: data)
        }
        return result;
    }
}
