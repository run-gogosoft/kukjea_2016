<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script id="tmpl-member-list" type="text/html">
    <tr>
        <td class="text-center"><%="${seq}"%></td>
        <td class="text-center"><%="${gradeName}"%></td>
        {{each access}}
            <td class="text-center"><%="${accessStatus}"%></td>
        {{/each}}
        <td class="text-center"><%="${groupName}"%></td>
        <td class="text-center"><a href="/admin/member/view/<%="${seq}"%>"><%="${id}"%></a></td>
        <td class="text-center"><%="${name}"%></td>
        <td class="text-center"><%="${deptName} / ${posName}"%></td>
        <td class="text-center"><%="${cell}"%></td>
        <td class="text-center"><%="${email}"%></td>
        <td class="text-center"><%="${totalOrderPrice}"%>원</td>
        <td class="text-center"><%="${point}"%>P</td>
        <td class="text-center"><%="${regDate}"%><br/><span class="text-info"><%="${lastDate}"%></span></td>
    </tr>
</script>