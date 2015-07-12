Option Strict On
'Author: Minh Nghiem
'Assignment: ASP6-Stored Procedure
'Date:3/20/2015
'Program Description:Use Stored Procedures To View Customers after Login
Public Class Login
    Inherits System.Web.UI.Page

    'Instantiate Class
    Dim EmpDB As New EmployeeDB
    Dim Valid As New ValidationClass

    'Declare module level
    Dim mintCount As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If first time visiting reset count
        If IsPostBack = False Then
            Session("Count") = 0
        End If
     
    End Sub

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click

        'start count from server
        mintCount = CInt(Session("count"))
        mintCount += 1

        'bring session count into server
        Session("Count") = mintCount

        'check to make sure ID is Integer 
        If Valid.CheckInteger(txtEmpID.Text) = -1 Then
            lblError.Text = ("EmpID or Password Is Incorrect")
            If mintCount >= 3 Then
                btnLogin.Enabled = False
            End If
            Exit Sub
        End If

        'validate username and password
        If EmpDB.CheckEmpLogin(txtEmpID.Text, txtPassword.Text) = False Or txtEmpID.Text = "" Or txtPassword.Text = "" Then
            lblError.Text = ("EmpID or Password Is Incorrect")
            If mintCount >= 3 Then
                btnLogin.Enabled = False
            End If
            Exit Sub
        End If

        'get session info for redirect
        Session("EmpType") = EmpDB.EmpDataset.Tables("tblEmployee").Rows(0).Item("Password").ToString

        'redirect
        Response.Redirect("Search.aspx")

    End Sub

End Class