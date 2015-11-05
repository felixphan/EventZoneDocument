$(function() {
    //Datetime Picker
    $("#datetimepicker1").datetimepicker();
    $("#datetimepicker2").datetimepicker({
        useCurrent: false
    });
        $('#datetimepicker2').data("DateTimePicker").minDate(moment());
    $("#datetimepicker2").on("dp.change", function (e) {
        $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
    });

//Description
    function initToolbarBootstrapBindings() {
        var fonts = [
                "Serif", "Sans", "Arial", "Arial Black", "Courier",
                "Courier New", "Comic Sans MS", "Helvetica", "Impact", "Lucida Grande", "Lucida Sans", "Tahoma", "Times",
                "Times New Roman", "Verdana"
            ],
            fontTarget = $("[title=Font]").siblings(".dropdown-menu");
        $.each(fonts, function(idx, fontName) {
            fontTarget.append($("<li><a data-edit=\"fontName " + fontName + "\" style=\"font-family:'" + fontName + "'\">" + fontName + "</a></li>"));
        });
        $("a[title]").tooltip({ container: "body" });
        $(".dropdown-menu input").click(function() { return false; })
            .change(function() { $(this).parent(".dropdown-menu").siblings(".dropdown-toggle").dropdown("toggle"); })
            .keydown("esc", function() {
                this.value = "";
                $(this).change();
            });

        $("[data-role=magic-overlay]").each(function() {
            var overlay = $(this), target = $(overlay.data("target"));
            overlay.css("opacity", 0).css("position", "absolute").offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
        });
        if ("onwebkitspeechchange" in document.createElement("input")) {
            var editorOffset = $("#editor").offset();
            $("#voiceBtn").css("position", "absolute").offset({ top: editorOffset.top, left: editorOffset.left + $("#editor").innerWidth() - 35 });
        } else {
            $("#voiceBtn").hide();
        }
    };

    function showErrorAlert(reason, detail) {
        var msg = "";
        if (reason === "unsupported-file-type") {
            msg = "Unsupported format " + detail;
        } else {
            console.log("error uploading file", reason, detail);
        }
        $("<div class=\"alert\"> <button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>" +
            "<strong>File upload error</strong> " + msg + " </div>").prependTo("#alerts");
    };

    initToolbarBootstrapBindings();
    $("#editor").wysiwyg({ fileUploadError: showErrorAlert });
    window.prettyPrint && prettyPrint();

    $(".d_stream_cover").fadeOut("slow");
    $("#IsLive").change(function() {
        if (this.checked) {
            $(".d_stream_cover").fadeIn("slow");
        } else {
            $(".d_stream_cover").fadeOut("slow");
        }
    });
    $("#btnAddLocation").click(function() {
        var length = $("input[id^=Location-]").length;
        $("#LocationInput").append("<div id=\"wrapper\">" +
            "<div class=\"col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xs-offset-2 col-sm-offset-2 col-md-offset-2 col-lg-offset-2 b\">" +
            "<input type=\"text\" class=\"LocationInput form-control\" id=\"Location-" + length + "\" onfocus=\"searchLocation(this)\" />" +
            "<input type=\"hidden\" id=\"Longitude-" + length + "\" class=\"LongitudeInput\" />" +
            "<input type=\"hidden\" id=\"Lattitude-" + length + "\" class=\"LangitudeInput\" />" +
            "</div>" +
            "<div class=\"col-xs-2 col-sm-2 col-md-2 col-lg-2 b\">" +
            "<button type=\"button\" class=\"btn btn-primary btnRemoveLocation\">Remove</button>" +
            "</div>" +
            "</div>");
    });
    $("#LocationInput").on("click", ".btnRemoveLocation", function() { //user click on remove text
        $(this).parent("div").parent("div").remove();
    });

    //Binding Locations to One Location String
    $("#btnSubmit").click(function () {
        var locationInputText = "";
        var longitudeInputText = "";
        var langitudeInputText = "";
        if (document.getElementById("Location-1") !== null) {
            $("[id^=Location-]").each(function(i, item) {
                locationInputText = locationInputText + $(item).val() + ";";
            });
            $("[id^=Longitude-]").each(function(i, item) {
                longitudeInputText = longitudeInputText + $(item).val() + ";";
            });
            $("[id^=Lattitude-]").each(function(i, item) {
                langitudeInputText = langitudeInputText + $(item).val() + ";";
            });
            $("#LocationName").val(locationInputText);
            $("#Longitude").val(longitudeInputText);
            $("#Lattitude").val(langitudeInputText);
        } else {
            $("#LocationName").val($("#Location-0").val() + ";");
            $("#Longitude").val($("#Longitude-0").val() + ";");
            $("#Lattitude").val($("#Lattitude-0").val() + ";");
        }
        $("#descriptionInput").val($("#editor").val());
        $(this).parents("form").submit();
    });
    $("#IsLive").click(function() {
        if ($(this).is(":checked")) $("#YoutubeOption").show();
    });
});