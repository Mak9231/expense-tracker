# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


* ...

<div id="chart-3" style="height: 300px; width: 100%; text-align: center; color: #999; line-height: 300px; font-size: 14px; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helvetica, sans-serif;"><canvas width="2754" height="600" style="display: block; box-sizing: border-box; height: 300px; width: 1377px;"></canvas></div>


<h1>All Expenses</h1>
<%= link_to 'New Expense', new_expense_path %>
<%= form_with url: expenses_path, method: :get, local: true do %>

    <p>
      <%= label_tag :query, "Rechercher par titre" %>
      <%= text_field_tag :query, params[:query] %>
    </p>

    <p>
      <%= label_tag :start_date, "Date de début" %>
      <%= date_field_tag :start_date, params[:start_date] %>
    </p>

    <p>
      <%= label_tag :end_date, "Date de fin" %>
      <%= date_field_tag :end_date, params[:end_date] %>
    </p>

    <p>
      <%= label_tag :category, "Catégorie" %>
      <%= select_tag :category, options_for_select(Expense.pluck(:category).uniq.prepend("Toutes"), params[:category]) %>
    </p>


  <%= submit_tag "filtrer" %>
<% end %>

<a href="/expenses/new">New Expense</a>
<h2 style="color:rgba(209, 24, 24, 0.57);">Total des dépenses : <%= number_to_currency(@total_amount, unit: "€", separator: ",", delimiter: " ") %></h2>
</div>
<%= line_chart @expenses_by_date, xtitle: "Date", ytitle: "Montant (€)", library: {backgroundColor: "#fff"} %>
<%= pie_chart @expenses_by_category, donut: true, library: {
  title: { text: "Répartition par catégorie", display: true },
  legend: { position: "bottom" }
} %>

<%= link_to "Exporter en CSV", export_expenses_path, class: "btn btn-success mb-3" %>

<table class="table table-striped">
  <thead>
    <tr>
      <th>Title</th>
      <th>Amount</th>
      <th>Date</th>
      <th>Category</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    <% @expenses.each do |expense| %>
      <tr>
        <td><%= expense.title %></td>
        <td><%= number_to_currency(expense.amount) %></td>
        <td><%= expense.date.strftime("%d %b %Y") %></td>
        <td><%= expense.category %></td>
        <td>
          <%= link_to 'Show', expense_path(expense), class: "btn btn-info" %>
          <%= link_to 'Edit', edit_expense_path(expense), class: "btn btn-warning" %>
          <%= link_to 'Delete', expense_path(expense), method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-danger" %>
        </td>
      </tr>
    <% end %>
  </tbody>
</table>



