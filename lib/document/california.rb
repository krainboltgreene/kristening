require 'prawn'
require 'rmagick'
require 'tempfile'
require 'fileutils'
require 'zip'

module Document
  module California
    include Magick

    def self.convert_to_pdf(png_page)
      pdf_page = png_page.gsub(/\.png/i, ".pdf")
      img = Magick::Image.ping(png_page).first
      width = img.columns
      height = img.rows

      # Image should be 300dpi
      # LETTER = 612.00 x 792.0
      # Which is 2550 px, 3300 px
      # This works out to 612 / 2550 = 0.24
      ratio = 0.24
      pdf_width = width * ratio
      pdf_height = height * ratio
      Prawn::Document.generate(pdf_page, :page_size => [pdf_width, pdf_height], :margin => 0) do
        STDERR.puts "Putting: #{png_page} of #{width},#{height} at [0,#{pdf_height}]"
        image png_page, :at => [0,pdf_height],  :width => pdf_width
      end
      STDERR.puts "Saved to: #{pdf_page}"
      return pdf_page
    end

    def self.write_png(png,outdir,filename)
      outfile = outdir.join(filename).to_s
      png.write(outfile)
      puts "Writing: #{outfile}"
      return outfile
    end

    def self.open_source_png(file)
      ImageList.new(Rails.root.join("forms/California/png/#{file}"))
    end

    def self.create_nc200(person, outdir)
      nc200 = open_source_png("nc200.png")
      text = Magick::Draw.new
      text.pointsize = 25

      # Add Dead Name
      text.annotate(nc200, 0,0,240,280, person[:dead_name]) {
        self.fill = 'black'
      }
      text.annotate(nc200, 0,0,400,370, person[:address]) {
        self.fill = 'black'
      }
      text.annotate(nc200, 0,0,270,420, person[:city]) {
        self.fill = 'black'
      }
      text.annotate(nc200, 0,0,1150,420, person[:state]) {
        self.fill = 'black'
      }
      text.annotate(nc200, 0,0,450,670, person[:court_address]) {
        self.fill = 'black'
      }
      text.annotate(nc200, 0,0,450,765, person[:court_location]) {
        self.fill = 'black'
      }
      text.annotate(nc200, 0,0,450,810, person[:court_name]) {
        self.fill = 'black'
      }

      # Checkbox for male to female
      text.annotate(nc200, 0,0,320,1700, "x") {
        self.fill = 'black'
      }

      #Checkbox for female to male
      text.annotate(nc200, 0,0,320,1760, "x") {
        self.fill = 'black'
      }
      write_png(nc200,outdir,"nc200_completed.png")
    end

    def self.create_nc110(person, outdir)
      nc110 = open_source_png("nc110.png")
      text = Magick::Draw.new
      text.pointsize = 25
      text.annotate(nc110, 0,0,385,240, person[:dead_name]) {
        self.fill = 'black'
      }
      #Part 7 b
      text.annotate(nc110, 0,0,310,695, "x") {
        self.fill = 'black'
      }
      #7b1
      text.annotate(nc110, 0,0,760,740, person[:dead_name]) {
        self.fill = 'black'
      }
      #7b2
      text.annotate(nc110, 0,0,785,790, person[:real_name]) {
        self.fill = 'black'
      }
      #7b3
      text.annotate(nc110, 0,0,750,845, person[:dob].strftime("%m/%d/%Y")) {
        self.fill = 'black'
      }
      #7b3 and presently
      text.annotate(nc110, 0,0,1195,895, "x") {
        self.fill = 'black'
      }
      #7b4
      text.annotate(nc110, 0,0,750,945, person[:born]) {
        self.fill = 'black'
      }
      #7b5
      text.annotate(nc110, 0,0,1385,990, "x") {
        self.fill = 'black'
      }
      #7b6
      text.annotate(nc110, 0,0,1395,1040, person[:address]) {
        self.fill = 'black'
      }
      #7b6 city
      text.annotate(nc110, 0,0,600,1095, person[:city]) {
        self.fill = 'black'
      }
      #7b6 state
      text.annotate(nc110, 0,0,800,1095, person[:state]) {
        self.fill = 'black'
      }
      #7b6 zip
      text.annotate(nc110, 0,0,1000,1095, person[:zip]) {
        self.fill = 'black'
      }
      #7c
      text.annotate(nc110, 0,0,700,1200, "Better match for my identity") {
        self.fill = 'black'
      }
      #7d
      text.annotate(nc110, 0,0,385,1340, "x") {
        self.fill = 'black'
      }
      #Declaration_not not in prison or on parole
      text.annotate(nc110, 0,0,1580,1960, "x") {
        self.fill = 'black'
      }
      #Declaration_not a sex offender
      text.annotate(nc110, 0,0,1765,2005, "x") {
        self.fill = 'black'
      }
      #Declaration_print dead name
      text.annotate(nc110, 0,0,550,2410, person[:dead_name]) {
        self.fill = 'black'
      }
      #Petitioner sign
      text.annotate(nc110, 0,0,550,2920, person[:dead_name]) {
        self.fill = 'black'
      }

      write_png(nc110,outdir,"nc110_completed.png")
    end

    def self.create_cm010(person, outdir)
      cm010 = open_source_png("cm010.png")
      text = Magick::Draw.new
      text.pointsize = 25

      #Party without attorney dead_name
      text.annotate(cm010, 0,0,200,190, person[:dead_name]) {
        self.fill = 'black'
      }
      #Party without attorney address
      text.annotate(cm010, 0,0,200,220, person[:address]) {
        self.fill = 'black'
      }
      #Pary without city
      text.annotate(cm010, 0,0,200,250, person[:city]) {
        self.fill = 'black'
      }
      #Party without state
      text.annotate(cm010, 0,0,400,250, person[:state]) {
        self.fill = 'black'
      }
      #party without zip
      text.annotate(cm010, 0,0,600,250, person[:zip]) {
        self.fill = 'black'
      }
      #party without telephone
      text.annotate(cm010, 0,0,500,335, person[:telephone]) {
        self.fill = 'black'
      }
      #superior court address
      text.annotate(cm010, 0,0,500,470, person[:court_address]) {
        self.fill = 'black'
      }
      #superior court city
      text.annotate(cm010, 0,0,500,565, person[:court_location]) {
        self.fill = 'black'
      }
      #superior court name
      text.annotate(cm010, 0,0,500,615, person[:court_name]) {
        self.fill = 'black'
      }
      #civil case cover sheet_unlimited
      text.annotate(cm010, 0,0,195,815, "x") {
        self.fill = 'black'
      }
      #case type check box
      text.annotate(cm010, 0,0,1620,1955, "x") {
        self.fill = 'black'
      }
      #case not complex
      text.annotate(cm010, 0,0,635,2095, "x") {
        self.fill = 'black'
      }
      #3.remedies sought
      text.annotate(cm010, 0,0,955,2425, "x") {
        self.fill = 'black'
      }
      #5.not class action
      text.annotate(cm010, 0,0,635,2530, "x") {
        self.fill = 'black'
      }
      #print name next to signature
      text.annotate(cm010, 0,0,165,2700, person[:dead_name]) {
        self.fill = 'black'
      }

      write_png(cm010,outdir,"cm010_completed.png")
    end

    def self.create_nc220(person, outdir)
      nc220 = open_source_png("nc220.png")
      text = Magick::Draw.new
      text.pointsize = 25
      #Petitioner info at the top
      text.annotate(nc220, 0,0,240,275, person[:dead_name]) {
        self.fill = 'black'
      }
      #petitioner address
      text.annotate(nc220, 0,0,410,375, person[:address]) {
        self.fill = 'black'
      }
      #petitioner city
      text.annotate(nc220, 0,0,235,420, person[:city]) {
        self.fill = 'black'
      }
      #petitioner state
      text.annotate(nc220, 0,0,1120,420, person[:state]) {
        self.fill = 'black'
      }
      #petitioner zip
      text.annotate(nc220, 0,0,1375,420, person[:zip]) {
        self.fill = 'black'
      }
      #petitioner phone
      text.annotate(nc220, 0,0,385,470, person[:telephone]) {
        self.fill = 'black'
      }
      #court address
      text.annotate(nc220, 0,0,430,670, person[:court_address]) {
        self.fill = 'black'
      }
      #court city
      text.annotate(nc220, 0,0,430,760, person[:court_location]) {
        self.fill = 'black'
      }
      #court name
      text.annotate(nc220, 0,0,430,810, person[:court_name]) {
        self.fill = 'black'
      }

      write_png(nc220,outdir,"nc220_completed.png")
    end

    def self.create_nc230(person, outdir)
      nc230 = open_source_png("nc230.png")
      text = Magick::Draw.new
      text.pointsize = 25

      #petitioner info at top
      text.annotate(nc230, 0,0,240,220, person[:dead_name]) {
        self.fill = 'black'
      }
      #petitioner address
      text.annotate(nc230, 0,0,240,260, person[:address]) {
        self.fill = 'black'
      }
      #petitioner city
      text.annotate(nc230, 0,0,240,300, person[:city]) {
        self.fill = 'black'
      }
      #petitioner state
      text.annotate(nc230, 0,0,340,300, person[:state]) {
        self.fill = 'black'
      }
      #petitioner zip
      text.annotate(nc230, 0,0,440,300, person[:zip]) {
        self.fill = 'black'
      }
      #court info_address
      text.annotate(nc230, 0,0,525,635, person[:court_address]) {
        self.fill = 'black'
      }
      #court city
      text.annotate(nc230, 0,0,525,735, person[:court_location]) {
        self.fill = 'black'
      }
      #court name
      text.annotate(nc230, 0,0,525,785, person[:court_name]) {
        self.fill = 'black'
      }
      #The court finds 2b1
      text.annotate(nc230, 0,0,375,1385, "x") {
        self.fill = 'black'
      }
      #2b2
      text.annotate(nc230, 0,0,375,1435, "x") {
        self.fill = 'black'
      }
      #The court further orders
      text.annotate(nc230, 0,0,315,2335, "x") {
        self.fill = 'black'
      }
      write_png(nc230,outdir,"nc230_completed.png")
    end

    def self.create_zip(person)
      STDERR.puts "Person: #{person}"
      dirpath = Rails.root.join('tmp', "person#{person[:id]}-#{SecureRandom.hex(8)}")
      FileUtils.mkdir dirpath
      zip_path = dirpath.join("christening.zip").to_s
      STDERR.puts "Creating: #{zip_path}"
      Zip::File.open(zip_path, Zip::File::CREATE) do |zipfile|
        nc200_file = create_nc200(person, dirpath)
        zipfile.add("nc200.pdf", nc200_file)
        #FileUtils.rm nc200_file
        nc110_file = create_nc110(person, dirpath)
        zipfile.add("nc110.pdf", nc110_file)
        #FileUtils.rm nc110_file
        cm010_file = create_cm010(person, dirpath)
        zipfile.add("cm010.pdf", cm010_file)
        #FileUtils.rm cm010_file
        nc220_file = create_nc220(person, dirpath)
        zipfile.add("nc220.pdf", nc220_file)
        #FileUtils.rm nc220_file
        nc230_file = create_nc230(person, dirpath)
        zipfile.add("nc230.pdf", nc230_file)
        #FileUtils.rm nc230_file
      end
      return zip_path
    end

    def self.guide_text
      guide =<<EOT;
  You can find a great guide on completing and sending the forms at the Transgender Law Center.

  http://transgenderlawcenter.org/resources/id/id-change

  You will need to print the filled out PDFs and sign and date all applicable parts of the forms.
EOT
      guide
    end

    def self.guide_html
      guide =<<EOT;
  You can find a great guide on completing and sending the forms at the <a href="http://transgenderlawcenter.org/resources/id/id-change">Transgender Law Center</a>.

  You will need to print the filled out PDFs and sign and date all applicable parts of the forms.
EOT
      guide
    end
  end
end
