Airstrip.parseResponse = function(resp) {
    var data = {}

    try { 
        data = JSON.parse(resp.responseText)
    } catch(e) {
        data.error = 'Something went wrong!'
    }

    return data
}
