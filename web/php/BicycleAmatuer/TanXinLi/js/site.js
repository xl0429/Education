/* global $cahcedTextArea */

$(function() {
    
    // Reload page
    $("[type=reset]").click(function (e) {
        e.preventDefault();
        location = location;
    });
   
    // Check all checkboxes
    $("[data-check]").click(function (e) { 
        e.preventDefault();
        var name = $(this).data("check");
        $(`[name="${name}"]`).prop("checked", true).change();
    });
   
    // Uncheck all checkboxes
    $("[data-uncheck]").click(function (e) { 
        e.preventDefault();
        var name = $(this).data("uncheck");
        $(`[name="${name}"]`).prop("checked", false).change();
    });
    
    // Invert checkboxes
    $("[data-invert]").click(function (e) { 
        e.preventDefault();
        var name = $(this).data("invert");
        $(`[name="${name}"]`).each(function () {
            this.checked = !this.checked;           
        }).change();
    });
   
    // Auto uppercase
    $("[data-upper]").on("input", function (e) {
        var a = this.selectionStart;
        var b = this.selectionEnd;
        this.value = this.value.toUpperCase();        
        this.setSelectionRange(a, b);
    });
    
    // Load a page using GET request
    $("[data-get]").click(function (e) {
        e.preventDefault();
        var url = $(this).data("get");
        location = url;
    });
    
    // Submit the closest form
    $("[data-submit]").click(function (e) {
       e.preventDefault();
       $(this).closest("form").submit();
    });
    
    var max = $("[type=number]").attr("max");
    var min = $("[type=number]").attr("min");
    
    $('.add').click(function () {
        if ($(this).prev().val() < 10) {
            $(this).prev().val(+$(this).prev().val() + 1);
	} 
        
    });
    $('.sub').click(function () {
        if ($(this).next().val() > 1) {
            $('.sub').removeClass('disabled');
            if ($(this).next().val() > 1) $(this).next().val(+$(this).next().val() - 1);
            
        }
        
    });  
    
    $('[type=number]').on('keydown keyup', function(e){
        var max = $("[type=number]").attr("max");
        var min = $("[type=number]").attr("min");
        //var temp = $(this).data(val());
        if ($(this).val() > max 
           
            && e.keyCode !== 8 // keycode for backspace
        ) {
            //e.preventDefault();
            
            $(this).val(max);
          
        }else{
           // alert($(this).val())
        }
        if ($(this).val() < min   && e.keyCode !== 8 ) {
            //e.preventDefault();
           
            $(this).val(min);
              
        }
        
       
        
    });
    
    //category ip down arrow
    $(".dropdown").hover(function(){
       // if()
        $('i').toggleClass('down up');
    });
    
    //show password by check box
    $('.check').click(function(){
        var id = $(this).prev(['type=password']).attr('id');
        if(id === 'password')
            $(this).is(':checked') ? $('#password').attr('type', 'text') : $('#password').attr('type', 'password');
        if(id === 'confirm')
            $(this).is(':checked') ? $('#confirm').attr('type', 'text') : $('#confirm').attr('type', 'password');
        if(id === 'new')
            $(this).is(':checked') ? $('#new').attr('type', 'text') : $('#new').attr('type', 'password');
    });
    
    //clear input icon
    Array.prototype.forEach.call(document.querySelectorAll('.clearable-input>[data-clear-input]'), function(el) {
    el.addEventListener('click', function(e) {
        e.target.previousElementSibling.value = '';
        e.target.previousElementSibling.previousElementSibling.value = '';
        });
    });
    
    $('#pType').change(function() {
        $('#pTypeDiv').toggle();
    });
    
    /*delete product confirmation*/
    $('#delete').click(function(e){
        var c = confirm("Are you sure want to delete " + $(this).val() + " ?");
        var str = '/admin/delete_product.php?prod_id=' + $(this).val();
        if(c){
              location.href = str;
        }
        
    });
    
  
     
});

//textarea word count
$(function () {
    $('[data-textmax]').each(function(){
        //origin word count
        $(this).next('.countbox').html( $(this).data('textmax') - $(this).val().length+ "/" +$(this).data('textmax'));
        $(this).on('keyup keypress blur change', function() {
            var _this = $(this);
            var textMax = +_this.data('textmax');
            var textLen = _this.val().length;
            var textSub = textMax - textLen;
            var countbox = _this.next('.countbox');
            // optional
            if(textSub <= 0){ 
                avoidTyping( _this, textMax);
                textSub = 0;
                countbox.css('color','red'); // optional color
            }else{
                countbox.css('color',''); // optional color
            }
            // end optional
            countbox.html(textSub + '/' + textMax);

        });
    }); 
});

function avoidTyping(el, len){
    var str = (el.val()).slice(0, len);
    el.val(str);
}

$(document).ready(function() {
    var $b = $('.fBtn');
    var $p = $('.form');

    $b.click(function() {
        var i = $b.index(this);
        $p.hide().eq(i).show();
    });
});

      