<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%--
  Created by IntelliJ IDEA.
  User: djlee
  Date: 2021-08-15
  Time: 오후 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
<h2>${bbstype}</h2>
    <c:choose>
    <c:when test="${empty list}">
        <h1>작성하신 글이 없습니다.</h1>
    </c:when>
    <c:otherwise>
        <table border="1" style="width: 70%">
            <colgroup>
                <col style="width:10%;" />
                <col style="width:auto;" />
                <col style="width:15%;" />
                <col style="width:10%;" />
                <col style="width:20%;" />
            </colgroup>

            <thead>
            <tr>
                <th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th>
            </tr>
            </thead>

            <tbody>
                <c:forEach var="data" items="${list}">
                    <c:if test="${data.del != '1'}">
                        <tr>
                            <td>${data.community_seq }</td>
                            <!-- bbstype에 따라서 if문으로 걸러줘야함 -->
                            <td><a href="/community/helloDetail.do?community_seq=${data.community_seq}">${data.title}</a></td>
                            <td>${data.nickname}</td>
                            <td>${data.readcount}</td>
                            <td>
                                <c:set var="date" value="${data.wdate}"/>
                                    ${fn:substring(date,2,16)}
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
    </c:choose>
</div>

<div class="container"> <!-- style = "width : 100%; text-align : center" -->
    <!--  <div style = "display : inline-block"> -->
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination"></ul>
    </nav>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        //페이지네이션
        let totalCount = ${totalCount};	// 서버로부터 총글의 수를 취득
        //alert(totalCount);

        let nowPage = ${nowPage};	// 서버로부터 현재 페이지를 취득
        //alert(nowPage);

        let pageSize = 15;//페이지의 크기(1~10) [1] ~ [10]

        let totalPages = totalCount / pageSize;

        if(totalCount % pageSize > 0){
            totalPages++;
        }

        /*페이지 갱신 : 페이징을 갱신해 줘야 번호가 재설정된다.*/
       if($('#pagination').data("twbs-pagination")){
            $('#pagination').twbsPagination('destroy');
        }

        $("#pagination").twbsPagination({
            startPage : nowPage,
            totalPages : totalPages, //전체 페이지
            visiblePages: 10, //최대로 보여줄 페이지
            first: '<span sria-hidden="true">«</span>',
            prev: "이전",
            next: "다음",
            last: '<span sria-hidden="true">»</span>',
            initiateStartPageClick:false,
            onPageClick: function(event,page){
                location.href = "/account/community.do?bbstype=" + '${bbstype}' + "&pageNumber=" + (page - 1);
            }
        });
    });
</script>
</body>
</html>
