var validator = new FormValidator('web_form', [{
    name: 'first_name',display: 'required',rules: 'required'},
    {name: 'last_name',display: 'required',rules: 'required'},
    {name: 'email', display: 'required', rules: 'valid_email'}],
    function(errors, event) {
        if (errors.length > 0) {
        var errorString = '';

        for (var i = 0, errorLength = errors.length; i < errorLength; i++) {
            errorString += errors[i].message + '<br />';
        }

        el.innerHTML = errorString;
    }});