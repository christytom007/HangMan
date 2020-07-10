<%@page import="com.isi.web.model.GameManager.GameStatus"%>
<%@page import="com.isi.web.model.GameManager"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<head>
	<meta charset="ISO-8859-1">
	<title>Hangman Game</title>
	<style type="text/css">
		body {
			font-family: "Raleway", sans-serif;
			background-image: url('pic3.jpg');
			min-height: 100%;
			background-position: center;
			background-size: cover;
		}

		.gameTitle {
			color: red;
			text-align: center;
		}

		.word {
			border-collapse: collapse;
			text-align: center;
		}

		.word td {
			border-bottom: 1px solid yellowgreen;
			padding: 15px 20px;
			font-size: 25px;
			color: orange;
		}

		.btn-group .button {
			background-color: #4CAF50;
			/* Green */
			border: 1px solid green;
			color: Black;
			padding: 15px 20px;
			text-align: center;
			text-decoration: none;
			text-transform: uppercase;
			display: inline-block;
			font-size: 16px;
			cursor: pointer;
		}

		.btn-group .button:not (:last-child) {
			border-right: none;
			/* Prevent double borders */
		}

		.btn-group .button:hover {
			background-color: #3e8e41;
		}

		.btn-group {
			text-align: center;
		}

		button[type="submit"]:disabled {
			background: #dddddd;
		}

		button[type="submit"]:disabled:hover {
			background: #dddddd;
		}

		.guessCount {
			text-align: center;
			color: black;
		}

		.modal {
			display: none;
			/* Hidden by default */
			position: fixed;
			/* Stay in place */
			z-index: 1;
			/* Sit on top */
			padding-top: 100px;
			/* Location of the box */
			left: 0;
			top: 0;
			width: 100%;
			/* Full width */
			height: 100%;
			/* Full height */
			overflow: auto;
			/* Enable scroll if needed */
			background-color: rgb(0, 0, 0);
			/* Fallback color */
			background-color: rgba(0, 0, 0, 0.4);
			/* Black w/ opacity */
		}

		/* Modal Content */
		.modal-content {
			position: relative;
			background-color: #fefefe;
			margin: auto;
			padding: 0;
			border: 1px solid #888;
			width: 80%;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-animation-name: animatetop;
			-webkit-animation-duration: 0.4s;
			animation-name: animatetop;
			animation-duration: 0.4s
		}

		/* Add Animation */
		@-webkit-keyframes animatetop {
			from {
				top: -300px;
				opacity: 0
			}

			to {
				top: 0;
				opacity: 1
			}
		}

		@keyframes animatetop {
			from {
				top: -300px;
				opacity: 0
			}

			to {
				top: 0;
				opacity: 1
			}
		}

		/* The Close Button */
		.close {
			color: white;
			float: right;
			font-size: 28px;
			font-weight: bold;
		}

		.close:hover,
		.close:focus {
			color: #000;
			text-decoration: none;
			cursor: pointer;
		}

		.modal-header {
			padding: 2px 16px;
			background-color: #5cb85c;
			color: white;
		}

		.modal-body {
			padding: 2px 16px;
		}

		.modal-footer {
			padding: 2px 16px;
			background-color: #5cb85c;
			color: white;
		}
	</style>
</head>

<body>
	<div class="gameTitle">
		<h1>Hangman Game</h1>
	</div>

	<br />
	<br />
	<br />

	<%
		if (GameManager.getGameStatus() == GameStatus.NOT_STARTED)
			GameManager.initGame();
	%>

	<div class="word">
		<table align="center">
			<tr>
				<%
					char[] predictedWord = GameManager.getPredictedWord();
					for (int i = 0; i < GameManager.getCurrentWordSize(); i++) 
					{%>
				<td> <%= Character.toUpperCase(predictedWord[i]) %></td>
				<%}
				%>
			</tr>
		</table>
	</div>

	<br />
	<br />
	<br />

	<%
		char alphabet = 'a';
		String buttonDisable;
		boolean[] gussedLetters = GameManager.getGussedLetters();
	%>

	<div class="btn-group">
		<form method="post">
			<%
				for (alphabet='a'; alphabet <= 'm'; alphabet++) {
					if(gussedLetters[alphabet - 'a'] || GameManager.getGameStatus() == GameStatus.ENDED)
						buttonDisable = "disabled";
					else
						buttonDisable = ""; %>
			<button type="submit" formaction="requestHandler?action=select&letter=<%=alphabet%>" class="button"
				<%=buttonDisable%>> <%=alphabet%></button>
			<%}%>
		</form>
	</div>
	<br/>
	<br/>
	<div class="btn-group">
		<form method="post">
			<%
				for (alphabet='n'; alphabet <= 'z'; alphabet++) {
					if(gussedLetters[alphabet - 'a'] || GameManager.getGameStatus() == GameStatus.ENDED)
						buttonDisable = "disabled";
					else
						buttonDisable = ""; %>
			<button type="submit" formaction="requestHandler?action=select&letter=<%=alphabet%>" class="button"
				<%=buttonDisable%>> <%=alphabet%></button>
			<%}%>
		</form>
	</div>

	<br />
	<br />
	<br />
	<div class="guessCount">
		<h3>Wrong Guesses : <%= GameManager.getWrongGuessCount() %></h3>
	</div>
	<br />
	<br />
	<br />
	<div class="w3-center">
		<div class="w3-bar">
			<form method="post">
				<button type="submit" formaction="requestHandler?action=home" class="w3-button w3-teal">Home</button>
				<button type="submit" formaction="requestHandler?action=reset" class="w3-button w3-red">Restart</button>
			</form>
		</div>
	</div>


	<%if(GameManager.getGameStatus() == GameStatus.ENDED){%>
	<div id="myModal" class="modal" style="display: block">
		<!-- Modal content -->
		<div class="modal-content">
			<div class="modal-header">
				<span class="close">&times;</span>
				<h2>You Have Won !!!</h2>
			</div>
			<div class="modal-body">
				<p>You won the game with <%= GameManager.getWrongGuessCount() %> wrong guesses.</p>
			</div>
			<div class="modal-footer">
				<h3 style="text-transform: uppercase;">WORD : <%= predictedWord %> </h3>
			</div>
		</div>
	</div>
	<%}%>
</body>

<script type="text/javascript">
	//Get the modal
	var modal = document.getElementById("myModal");

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];

	// When the user clicks on <span> (x), close the modal
	span.onclick = function ()
	{
		modal.style.display = "none";
	}

</script>

</html>