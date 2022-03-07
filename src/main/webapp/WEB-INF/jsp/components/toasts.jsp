<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!-- Toasts -->
<div class="toast-container position-absolute top-0 end-0 m-2">          
    <div id="errorToast" class="toast text-white bg-danger border-0" role="alert" aria-live="polite" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                ... message ...
            </div>
        </div>
    </div>
    <div id="successToast" class="toast text-white bg-success border-0" role="alert" aria-live="polite" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                ... message ...
            </div>
        </div>
    </div>
</div>