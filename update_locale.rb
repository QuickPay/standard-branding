#!/usr/bin/env ruby
require "digest/md5"

SINGLE_REGEX = /\{\%\s*t ([^\%\}]*)\s*\%\}/
BLOCK_BEGIN  = /\{\%\s*translate\s.*\%\}/
BLOCK_END    = /\{\%\s*endtranslate\s*\%\}/

items = {}

Dir.glob("templates/**/*.liquid").each do |file|
  lines      = File.readlines(file)
  line_num   = 1
  block_mode = false

  lines.each do |line|
    if line.match(BLOCK_END)
      token = Digest::MD5.hexdigest(items["block"]["msgid"].join(""))
      items[token] = items["block"]
      items.delete("block")
      block_mode = false
    end

    if block_mode
      items["block"]["msgid"] << line.chomp
    else
      matches = line.scan(SINGLE_REGEX)

      unless matches.empty?
        occurences = matches.flatten!.map!(&:strip)

        occurences.each do |msgid|
          token = Digest::MD5.hexdigest(msgid)
          items[token] ||= {}
          items[token]["msgid"] = [msgid]
          items[token]["references"] ||= []
          items[token]["references"] << "#: #{file}:#{line_num}"
        end
      end
    end

    if line.match(BLOCK_BEGIN)
      block_mode = true
      items["block"] = {}
      items["block"]["msgid"] = []
      items["block"]["references"] = []
      items["block"]["references"] << "#: #{file}:#{line_num}"
    end

    line_num += 1
  end
end

open("locales/branding.pot", "w+") do |potfile|
  potfile << <<-'POT'
# SOME DESCRIPTIVE TITLE.
# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
# This file is distributed under the same license as the PACKAGE package.
# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
#
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: PACKAGE VERSION\n"
"Report-Msgid-Bugs-To: \n"
"POT-Creation-Date: 2016-10-28 08:21+0000\n"
"PO-Revision-Date: 2016-10-28 08:21+0000\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"Language: \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"
"Plural-Forms: nplurals=1; plural=0;\n"
POT

  items.each do |_, item|
    potfile << "\n"
    potfile << item["references"].join("\n") + "\n"
    if item["msgid"].count > 1
      potfile << "msgid \"\"\n"
      item["msgid"].each_with_index do |x, index|
        if index < (item["msgid"].count - 1)
          potfile << "\"#{x}" + '\n"' + "\n"
        else
          potfile << "\"#{x}\"" + "\n"
        end
      end
    else
      potfile << "msgid \"#{item['msgid'].first}\"\n"
    end
    potfile << "msgstr \"\"\n"
  end
end

Dir.glob("locales/**/*.po").each do |file|
  print file
  `msgmerge --update --no-wrap #{file} locales/branding.pot`
end

# .mo file compilation is now handled in
# https://translate.quickpay.net/projects/quickpay/standard-branding
# Dir.glob("./locales/*/*/") do |locale_dir|
#   po_file = "#{locale_dir}branding.po"
#   mo_file = "#{locale_dir}branding.mo"
#   `msgfmt #{po_file} -o #{mo_file}`
# end
