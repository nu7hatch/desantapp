/**
 * Public: Parses given response according to convention that
 * in case of failure an 'error' field should be provided.
 *
 * resp - A response object to be handled.
 *
 * Returns parsed response data.
 */
Airstrip.parseResponse = function(resp) {
    var data = {}

    try { 
        data = JSON.parse(resp.responseText)
    } catch(e) {
        data.error = 'Something went wrong!'
    }

    return data
}
