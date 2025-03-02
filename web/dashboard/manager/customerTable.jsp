<%-- 
    Document   : customerTable.jsp
    Created on : Mar 2, 2025, 10:07:10 PM
    Author     : Admin
--%>

<tbody>
    <c:forEach items="${customers}" var="c" varStatus="status">
        <tr>
            <td>${status.index + 1}</td>
            <td>${c.username}</td>
            <td>${c.profile.firstName}</td>
            <td>${c.profile.lastName}</td>
            <td>${c.profile.gender ? "Male" : "Female"}</td>
            <td>${c.email}</td>
            <td>${c.profile.phone}</td>
            <td>
                <span class="badge ${c.status ? 'badge-success' : 'badge-danger'}">
                    ${c.status ? 'Active' : 'Inactive'}
                </span>
            </td>
            <td class="text-center text-nowrap">
                <form action="customers" method="POST" class="change-status-form d-inline">
                    <input type="hidden" name="id" value="${c.id}">
                    <input type="hidden" name="status" value="${c.status}">
                    <input type="hidden" name="action" value="change">
                    <button type="submit" class="btn ${c.status ? 'red' : 'green'} mb-2">
                        <i class="fa fa-refresh" aria-hidden="true"></i> ${c.status ? 'Deactivate' : 'Activate'}
                    </button>
                </form>
                <a href="customer?id=${c.id}" class="btn green mb-2">
                    <i class="fa fa-pencil" aria-hidden="true"></i> Edit
                </a>
            </td>
        </tr>
    </c:forEach>
</tbody>

