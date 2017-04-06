<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script id="tmpl-member-list" type="text/html">
    <tr>
        <td class="text-center"><%="${seq}"%></td>
        <td class="text-center"><%="${gradeName}"%></td>
        {{each access}}
            {{if accessStatus=="X"}} <td class="text-center"><span class="text-warning">미요청</span></td>{{/if}}
            {{if accessStatus=="A"}} <td class="text-center"><span class="text-success">이용</span></td>{{/if}}
            {{if accessStatus=="N"}} <td class="text-center"><span class="text-danger">거절</span></td>{{/if}}
            {{if accessStatus=="R"}} <td class="text-center"><span class="text-danger">요청</span></td>{{/if}}
            {{if accessStatus=="H"}} <td class="text-center"><span class="text-warning">보류</span></td>{{/if}}
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