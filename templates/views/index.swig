{% extends "../layouts/default.swig" %}

{% macro showPost(post) %}
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 col-hack">
		<div class="ju-block">
			{% if post.image.exists %}
				<a href="/portfolio/project/{{ post.slug }}">
					<img src="{{ post._.image.fit(160,160) }}" class="img">
				</a>
			{% endif %}
			<div class="inner">
				<h2>{{ post.title }}</h2>
				<p>{{ post.content.brief | safe }}</p>
				<br/><br/>
				<a class="btn btn-primary" href="/portfolio/project/{{ post.slug }}">More&nbsp;&nbsp;<span class="fa fa-chevron-circle-right" aria-hidden="true"></span></a>
			</div>
		</div>
	</div>
{% endmacro %}

{% block content %}
	<div class="container">
		<div class="jumbotron">
			<h1>Hello</h1>
			<p><span id="typed-js"></span>&nbsp;</p>
		</div>
	</div>

	<div class="container">
		<div class="row">

			{% for post in data.posts %}
				{{ showPost(post) }}
			{% endfor %}

		</div>
	</div>

{% endblock %}
