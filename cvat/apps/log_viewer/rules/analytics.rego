package analytics

import rego.v1

import data.utils

# input: {
#     "scope": <"view"> or null,
#     "auth": {
#         "user": {
#             "id": <num>,
#             "privilege": <"admin"|"business"|"user"|"worker"> or null
#         },
#         "organization": {
#             "id": <num>,
#             "owner": {
#                 "id": <num>
#             },
#             "user": {
#                 "role": <"owner"|"maintainer"|"supervisor"|"worker"> or null
#             }
#         } or null,
#     },
#     "resource": {
#         "visibility": <"public"|"private"> or null,
#     }
# }

default allow := false

allow if {
    utils.is_admin
}

allow if {
    input.resource.visibility == utils.PUBLIC
    input.scope == utils.VIEW
    utils.has_perm(utils.BUSINESS)
}
