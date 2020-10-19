$(document).ready(function () {
    $('.chkShowPass input[type=checkbox]').change(function () {
        $('.password').attr('type', $(this).is(':checked') ? 'text' : 'password');
    });  
    
    
});
function checkPasswordStrength() {
    var number = /([0-9])/;
    var alphabets = /([a-zA-Z])/;
    var special_characters = /([ @, _,~ ,# ])/;

    if ($('.passStrength').val().length < 6) {
        
        $('#password-strength-status').removeClass();
        $('#password-strength-status').addClass('weak-password');
        $('#password-strength-status').html("Weak (should be atleast 6 characters.)");
    } else {

        if ($('.passStrength').val().match(number) && $('.passStrength').val().match(alphabets) && $('.passStrength').val().match(special_characters)) {
            $('#password-strength-status').removeClass();
            $('#password-strength-status').addClass('strong-password');
            $('#password-strength-status').html("Strong");
        } else {
            $('#password-strength-status').removeClass();
            $('#password-strength-status').addClass('medium-password');
            $('#password-strength-status').html("Medium (should include alphabets, numbers and special characters.)");
        }
    }
    $("#password-strength-status").show();
    setTimeout(function () { $('#password-strength-status').fadeOut() }, 8000);
}
