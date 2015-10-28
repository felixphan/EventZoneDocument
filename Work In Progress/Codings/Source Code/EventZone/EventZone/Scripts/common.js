var commonModule= (function(){
    var callAjax = function (controller, parameters, callbackMethod) {
        $.ajax({
            url: controller,
            type: 'POST',
            dataType: 'json',
            data: parameters,
            success: function (data) {
                if (callbackMethod) {
                    eval(callbackMethod);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (callbackMethod) {
                    var data = "error";
                    eval(callbackMethod);
                }
            }
        });

    }
    var likePost = function () {
        $(".btn-like").each(function (e) {
            $(this).click(function (evt) {
                if (evt.handled !== true) { // This will prevent event triggering more then once
                    evt.handled = true;
                    var likeIcon = $(this).closest(".panel-body").find(".fa-thumbs-o-up");

                    likeIcon.toggleClass("interacted")
                            .toggleClass("fa-thumbs-up");

                    var likeCountElement = $(this).closest(".panel-body").find(".like-count");

                    if (likeIcon.hasClass("interacted")) {
                        likeCountElement.text(parseInt(likeCountElement.text()) + 1);
                    } else {
                        likeCountElement.text(parseInt(likeCountElement.text()) - 1);
                    }
                    likeAjax(this);
                }
            });
        })
    };

    var dislikePost = function () {
        $(".room-detail-post-list .btn-dislike").each(function (e) {
            $(this).click(function (evt) {
                if (evt.handled !== true) { // This will prevent event triggering more then once
                    evt.handled = true;
                    var dislikeIcon = $(this).closest(".panel-body").find(".fa-thumbs-o-down");
                    dislikeIcon.toggleClass("interacted")
                            .toggleClass("fa-thumbs-down");
                    var dislikeCountElement = $(this).closest(".panel-body").find(".dislike-count");
                    if (dislikeIcon.hasClass("interacted")) {
                        dislikeCountElement.text(parseInt(dislikeCountElement.text()) + 1);
                    } else {
                        dislikeCountElement.text(parseInt(dislikeCountElement.text()) - 1);
                    }
                    dislikeAjax(this);
                }
            });
        });
    };

    var likeAjax = function (event) {
        var controller = "/User/Like";
        var eventID = parseInt($(event).attr("role"));
        var data = {
            eventID: eventID
        }

        commonModule.callAjax(controller, data, null);
    };
    var dislikeAjax = function (event) {
        var controller = "/User/Dislike";
        var eventID = parseInt($(event).attr("role"));
        var data = {
            eventID: eventID
        }

        commonModule.callAjax(controller, data, null);
    };
    return {
        callAjax: callAjax,
        likePost: likePost,
        dislikePost: dislikePost
    }
})