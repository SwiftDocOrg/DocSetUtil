# docsetutil

This is an unofficial mirror of `docsetutil`:
a developer tool for working with `.docset` bundles
that was removed in Xcode 9.3.

## Installation

### Homebrew

Run the following command to install using [homebrew](https://brew.sh/):

```terminal
$ brew install swiftdocorg/formulae/docsetutil
```

### Manually

Run the following commands to build and install manually:

```terminal
$ git clone https://github.com/SwiftDocOrg/DocSetUtil.git
$ cd DocSetUtil
$ make install
```

## Manual

<pre>
docsetutil(1)             BSD General Commands Manual            docsetutil(1)
</pre>

### Name

**docsetutil** -- Index, search, test, and package documentation sets

### Synopsis

<pre>
<strong>docsetutil</strong> index [options] <var>docsetpath</var>
<strong>docsetutil</strong> search [options] <var>docsetpath</var>
<strong>docsetutil</strong> validate [options] <var>docsetpath</var>
<strong>docsetutil</strong> dump [options] <var>docsetpath</var>
<strong>docsetutil</strong> package [options] <var>docsetpath</var>
<strong>docsetutil</strong> help
</pre>

### Description

Documentation sets are special bundles which hold documentation that can
be loaded and searched by Xcode 3.0 and later.

The **docsetutil** tool performs several operations on documentation sets.
The tool's primary operations are generating the full-text and API
indexes for a documentation set bundle and then packaging up the documen-
tation set for distribution. When indexing, the tool uses one or more XML
files in the bundle's Resources folder to learn about the contents of the
documentation set.  Once the indexes are generated, **docsetutil** can be
used to test and perform searches on those indexes.

### Common Options

Most **docsetutil** verbs accept the following options:

<dl>
<dt>
    <code>-localization <var>loc</var></code>
</dt>  
<dd>

Perform the operation using a particular localization
in the documentation set bundle.  Documentation sets
can be localized. This option tells **docsetutil** which
localization to load or create (when indexing).  _loc_
is a string, such as **en** or **ja** , that matches an **lproj**
folder in the bundle.

</dd>
<dt>
    <code>-skip-text</code>
</dt>         
<dd>

Do not perform the operation for the full-text index.
For example, when performing a search for an API sym-
bol, you may not want to also perform a full-text
search.  Also, because generating the indexes can be
time consuming for large documentation sets, you may
not want to create both indexes while developing and
testing your own documentation set.

</dd>
<dt>
    <code>-skip-api</code>         
</dt>
<dd>

Do not perform the operation for the API index.  
Similar to the **-skip-text** option.

</dd>
<dt>
    <code>-node <var>nodePath</var></code>
</dt>     
<dd>

Perform the operation only on the documents that
reside at or below a particular location in the docu-
mentation set's table-of-contents node hierarchy.  The
syntax is a colon-separated list of node names identi-
fying how to navigate to the desired node, starting
with the root node.  For example, **-node** **'Library**
**Documentation:Tutorial'** would limit the operation to a
second-level node (and all of its descendents) named
"Tutorial" below the root node named "Library Documen-
tation".  Because there is only one root node, its
inclusion is optional, so the previous example could
just be written as **-node** **'Tutorial'**.

</dd>
<dt>
    <code>-verbose</code>
</dt>
<dd>

Print out additional information about the operation being performed.

</dd>
<dt>
    <code>-debug</code>
</dt>
<dd>

Print out detailed information about the operation
being performed, which will likely be useful only when
trying to track down a failure.

</dd>
</dl>

### Verbs

The operations supported by docsetutil are:

<dl>
<dt>
    <code>help</code>
</dt>
<dd>

Display minimal usage information for the tool.  **help** accepts
no options.

</dd>
<dt>
    <code>index</code>
</dt>
<dd>

Convert the XML files describing the documentation set into a
binary form and generate a full-text index of the contents of
the documentation.

</dd>
<dd>

Common options:
`-localization`, `-skip-text`, `-skip-api`, `-node`,
`-verbose`, and `-debug`

</dd>
<dd>

Options:

<dl>
<dt>
    <code>-fallback</code> <var>path</var></code>
</dt>
<dd>

Documentation sets can distribute their content
between the installed bundle and an alternative loca-
tion, usually a website.  This optional value tells
**docsetutil** where to look (locally) for additional con-
tent that needs to be indexed.

</dd>
<dt>
    <code>-download</code>
</dt>
<dd>

If a node uses an absolute URL for its landing page,
download that page and include it in the full-text
index.

</dd>
</dl>
<dt>
    <code>search</code>
</dt>
<dd>

Search the full-text and API indexes for the specified term(s).

</dd>
<dd>

Common options: 
`-localization`, `-skip-text`, `-skip-api`, `-node`,
`-verbose`, and `-debug`.

</dd>
<dd>

Options:

<dl>
<dt>
    <code>-query</code> <var>str</var>
</dt>
<dd>

The string to search for in both the full-text and API
index.  This option is required when searching.

When searching the full-text index, _str_ is treated as
a SearchKit query, so you can perform complex queries.
For example, you can use

<pre>
<strong>-query</strong> 'Xcode && build*'
</pre>

to search for all documents that mention Xcode and
also contain a word starting with "build".

When searching the API index, _str_ is normally treated
as an exact, case-insensitive symbol name; no wild
cards are allowed. However, the API search can be con-
strained using the extended syntax
_language/type/scope/name_, where _language_ is the lan-
guage in which the symbol is defined, _type_ is a spe-
cial identifier that specifies the type of symbol for
which to search, _scope_ is the namespace or container
(such as class) in which the symbol is defined, and
_name_ is the actual name of the symbol. Furthermore,
this syntax performs a case-sensitive search for the
symbol scope and name.  If the symbol has no scope
(ie, it is a global symbol), use '-'; if you don't
want to constrain the search with one of the terms use
'*'.  To search for all Objective-C symbols defined
inside the NSWindow class, you can do:

<pre>
<strong>-query</strong> 'Objective-C/*/NSWindow/*'
</pre>

</dd>
<dt>
    <code>validate</code>
</dt>
<dd>

Examine the indexes for all the files referenced and verify
that those files actually exist in the documentation set (or
its fallback location).

</dd>
<dd>

Common options:
`-localization`, `-skip-text`, `-skip-api`, `-verbose`,
and `-debug`.

</dd>
<dd>

Options:

<dl>
<dt>
    <code>-fallback</code> <var>path</var>
</dt>
<dd>

Documentation sets can distribute their content
between the bundle and an alternative location, usu-
ally a website.  This optional value tells **docsetutil**
where to look (locally) for additional content against
which the indexes should be checked.  If you indexed
the documentation set with a fallback location, you
should also specify the same (or equivalent) location
when validating the indexes.

</dd>
</dl>
</dd>
<dt>
    <code>dump</code>
</dt>
<dd>

Print out the contents of the indexes.  The table-of-contents
will be printed out in an indented style to reflect the struc-
ture; the set of files that were included in the full-text
index will be listed and grouped according to the document to
which each file belongs and the location at which each document
was found; and brief descriptions of all the symbols in the API
index will be listed.

</dd>
<dd>

Common options: 
`-localization`, `-skip-text`, `-skip-api`, `-node`,
`-verbose`, and `-debug`.

</dd>
<dd>
Options:
<dl>
<dt>
    <code>-toc-depth</code> <var>N</var>
</dt>
<dd>

When printing out the table-of-content hierarchy,
descend only _N_ levels deep.  _N_ of 0 means display only
the highest level node; do not descend into the hier-
archy.  The default value is 5.

</dd>
<dt>
    <code>-text-depth</code> <var>N</var>
</dt>
<dd>

When printing the files from the full-text index, dis-
play the full-text hierarchy of location, document,
and file to a particular depth.  _N_ of 0 means display
only the high-level locations (ie, default documenta-
tion set location, the fallback location, or a website
URL) at which nodes were indexed.  _N_ of 1 means fur-
ther display the relative path of each node indexed
inside each location.  _N_ of 2 means further display
the relative path of each file indexed inside each
node.  The default value is 1.

</dd>
</dl>

</dd>
<dt>
    <code>package</code>   
</dt>
<dd>

Generate an XAR archive of the documentation set appropriate
for downloading and installing by Xcode.

</dd>
<dd>

Common options:
`-verbose`, and `-debug`.

</dd>
<dd>

Options:

<dl>
<dt>
    <code>-output</code> <var>packagePath</var>
</dt>
<dd>

The path of the archive to create.  If this option is
not used, the archive is written to the same folder as
the source documentation set with the same name as the
documentation set, except with the ".docset" extension
changed to ".xar".

</dd>
<dt>
    <code>-signid</code> <var>identityName</var>
</dt>
<dd>

Include a digital signature in the archive using the
specified identity.  Xcode will validate this signa-
ture before installing the documentation.  **docsetutil**
searches the current user's keychains for an identity
with the given name.

</dd>
<dt>
    <code>-atom <var>atomPath</var></code>
</dt>
<dd>

Generate or update an entry about the documentation
set in an Atom feed file at the given location.  If no
file exists at the location, yet, **docsetutil** will cre-
ate a new Atom file there with a single entry about
the documentation set.  Xcode is able to subscribe to
RSS and Atom feeds to learn about and download updates
to documentation sets.

</dd>
<dt>
    <code>-download-url</code> <var>downloadURL</var>
</dt>
<dd>

Use the given URL as the download location of the
package in the feed entry.  If a new feed entry is
created, but this option is not specified, **docsetutil**
will use a placeholder in the entry, which you will
need to edit before publishing the feed.

</dd>
</dl>
</dd>
</dl>

* * *

<pre>
Mac OS                         November 6, 2011                         Mac OS  
</pre>
