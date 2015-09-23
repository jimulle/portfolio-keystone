{% extends "../layouts/default.swig" %}

{% macro showPost(post) %}
	<div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 col-hack">
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

{% block intro %}
	<div class="container">

	</div>
{% endblock %}

{% block content %}
	<div class="container">
		<div class="row">

			<div class="col-xs-12 col-sm-12 col-md-4 col-lg-3">
				<div class="ju-block">
					<div class="inner">
						{% set title = "Portfolio" %}
						{% if data.category %}
							{% set title = data.tag.name %}
						{% endif %}
						<h1>{{ title }}</h1>
						<br/><br/>
						<p class="h4">Filter by tags: </p>
						<span class="h4">
							<a class="label {% if !data.tag %}label-primary{% else %}label-default{% endif %}" href="/portfolio">All</a>
							{% for tag in data.tags %}
								<a class="label {% if data.tag and data.tag.id == tag.id %}label-primary{% else %}label-default{% endif %}" href="/portfolio/{{ tag.key }}">{{tag.name}}</a>
							{% endfor %}
						</span>
					</div>
				</div>
			</div>

			<div class="col-xs-12 col-sm-12 col-md-8 col-lg-9">
					<div class="row">

						{% for pro in data.projects.results %}
							{{ showPost(pro) }}
						{% endfor %}

					</div>
			</div>

		</div>
	</div>
{% endblock %}
