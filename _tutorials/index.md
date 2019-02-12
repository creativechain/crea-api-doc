---
title: Tutorials
section: Tutorials
exclude: true
---
{% assign nav = site.data.nav.toc | where: "collection", "tutorials" | first %}
<section id="{{ doc.id | slugify }}" class="row {{ doc.id | slugify }}">
	<section class="row">
		<p>Read, play, and <i>learn <b>Crea</b></i>.</p>
		{% if nav.docs %}
			{% assign sorted_nav_docs = nav.docs | sort: "position" %}
			{% for nav_doc in sorted_nav_docs %}
				{% assign collection = site.collections | where: "id", nav_doc.collection | first %}
				{% if collection %}
					<a id="{{ nav_doc.collection | slugify }}"></a>
					<h3>{{ nav_doc.title }}</h3>
					<ul>
						{% assign sorted_collection_docs = collection.docs | sort: "position" %}
						{% for doc in sorted_collection_docs %}
						<li>
							<a href="{{ doc.id | relative_url }}">{{ doc.title }}</a>
							<span class="overview">{{ doc.description | markdownify }}</span>
						</li>
						{% endfor %}
					</ul>
				{% endif %}
			{% endfor %}
		{% endif %}
	</section>
</section>
