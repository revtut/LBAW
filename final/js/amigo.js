$(document).ready(function () {

    $('#EditUserModal').click(function () {
        var name = $("#UserName").text();
        var email = $("#UserEmail").text();
        var cellphone = $("#UserCellphone").text();
        var birth = $("#UserBirth").text();

        //set form
        $('#name').val(name);
        $('#dateBirth').val(birth);
        $('#email').val(email);
        $('#contact').val(cellphone);
    });

    $('#EditPaymentModal').click(function (event) {
        event.preventDefault();

        var payment = $("#UserDonative").text();

        $('#sel1').val(payment);
    });


    $('#TabIrEvento i[data-original-title="Detalhes"]').click(function (event) {
        $('#seeEventModal form').trigger('reset');

        var closest_tr = $(this).closest('tr');
        var tr_id_attr = $(closest_tr).attr('id');
        var id = tr_id_attr.substring(tr_id_attr.indexOf("-") + 1, tr_id_attr.length);

        var description = $("#Evento-" + id + " td:nth-child(2)").text(),
            name = $("#Evento-" + id + " td:nth-child(6)").text();

        // Set form
        $('#seeEventName').val(name);
        $('#seeEventDescription').val(description);
    });

    $('#TabIrEvento i[data-original-title="Eliminar"]').click(confirmRemoveHistory);


    $('#TabPagEvento i[data-original-title="Editar"]').click(function (event) {
        $('#editEventPaymentModal form').trigger('reset');

        var closest_tr = $(this).closest('tr');
        var tr_id_attr = $(closest_tr).attr('id');
        var id = tr_id_attr.substring(tr_id_attr.indexOf("-") + 1, tr_id_attr.length);

        $('<input>').attr({
            type: 'hidden',
            id: "PayId",
            value: id
        }).appendTo('#editEventPaymentModal form');

        var date = $("#eventoPayment-" + id + " td:nth-child(3)").text(),
            price = $("#eventoPayment-" + id + " td:nth-child(5)").text(),
            url = $("#eventoPayment-" + id + " td:nth-child(2)").text(),
            reference = $("#eventoPayment-" + id + " td:nth-child(6)").text();

        // Set form
        $('#editEventPaymentDate').val(date);
        $('#editEventPaymentValue').val(price);
        $('#editEventPaymentReceipt').val(url);
        $('#editEventPaymentReference').val(reference);
    });

    $('#TabPagEvento i[data-original-title="Eliminar"]').click(confirmRemoveHistory);
    // $('#TabPagEvento i[data-original-title="Obter Fatura"]').click(imprimir);

    // $('#TabDonative i[data-original-title="Editar"]').click(editHistoryEntry);
    $('#TabDonative i[data-original-title="Eliminar"]').click(confirmRemoveHistory);
    // $('#TabDonative i[data-original-title="Obter Fatura"]').click(imprimir);

    //  $('#TabMercha i[data-original-title="Detalhes"]').click(editHistoryEntry);
    $('#TabMercha i[data-original-title="Eliminar"]').click(confirmRemoveHistory);
    // $('#TabMercha i[data-original-title="Obter Fatura"]').click(imprimir);

});

function editUser(id) {

    var name = $('#name').val(),
        email = $('#email').val(),
        birth = $('#dateBirth').val(),
        cellphone = $('#contact').val();

    //alert(name + email + birth + cellphone);

    $.post(
        "../api/edit_profile.php", {
            id: id,
            email: email,
            name: name,
            birth: birth,
            cellphone: cellphone
        },
        function (data, statusText, xhr) {
            $('#editProfile').modal('hide');

            $("#UserName").html(name);
            $("#UserEmail").html(email);
            $("#UserBirth").html(birth);
            $("#UserCellphone").html(cellphone);
            $("#UserNameNav").html(name + " (Amigo)");
        })
        .fail(function (error) {
            console.log(error);
            $('#friendStatus').fadeIn();
        });
}

function editUserPayment(id) {
    var payment = $('#sel1').val();

    $.post(
        "../api/edit_donative_meth.php", {
            id: id,
            payment: payment
        },
        function (data, statusText, xhr) {
            $('#methPayment').modal('hide');
            $("#UserDonative").html(payment);
        })
        .fail(function (error) {
            console.log(error);
            $('#friendStatus2').fadeIn();
        });
}


function removeHistoryEntry(id, type) {

    $.post(
        "../api/remove_hist_entry.php", {
            id: id,
            type: type
        },
        function (data, statusText, xhr) {
            alert("#" + type + "-" + id);
            $("#" + type + "-" + id).remove();
        })
        .fail(function (error) {
            $("#" + type + "-" + id).highlightAnimation(red, 1500);
        });
}

function confirmRemoveHistory() {
    var closest_tr = $(this).closest('tr');

    var tr_id_attr = $(closest_tr).attr('id');
    var type = tr_id_attr.substring(0, tr_id_attr.indexOf("-"));
    var id = tr_id_attr.substring(tr_id_attr.indexOf("-") + 1, tr_id_attr.length);

    $('#confirm').modal({
        backdrop: 'static',
        keyboard: false
    })
        .one('click', '#delete', function () {
            removeHistoryEntry(id, type);
        });
}


function editEventPagHistory() {
    var id = $('#PayId').val();

    //vars do form
    var date = $('#editEventPaymentDate').val(),
        price = $('#editEventPaymentValue').val(),
        receipt = $('#editEventPaymentReceipt').val(),
        reference = $('#editEventPaymentReference').val();

        console.log(date,price,receipt,reference);

    $.post(
        "../api/edit_hist_pay_event.php", {
            id: id,
            date: date,
            price: price,
            receipt: receipt,
            reference: reference
        },
        function (data, statusText, xhr) {
            $('#editEventPaymentModal').modal('hide');

            $("#eventoPayment-"+ id + " td:nth-child(3)").html(date);
            $("#eventoPayment-"+ id + " td:nth-child(5)").html(price);
            $("#eventoPayment-"+ id + " td:nth-child(2)").html(receipt);
            $("#eventoPayment-"+ id + " td:nth-child(6)").html(reference);
        })
        .fail(function (error) {
            $("#eventoPayment-"+ id).highlightAnimation(red, 1500);
        });

}