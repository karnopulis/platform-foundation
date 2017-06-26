require 'rmagick'
require 'net/ftp'

class Image < ApplicationRecord
    belongs_to :product
    
    def self.create(args)
        i =Image.new(args)
        i.filename = i.original_url.split("/").last
        i.getImage
#        i.save
        return i
    end
    
    
    def getImage

        prefix= self.filename.at(0..2).gsub(/[^0-9]/, '').rjust(3, '0') 
        file =get_csv_from_ftp( self.original_url,self.filename,prefix)
        self.original_url = "products/"+prefix+"/original_"+self.filename

        img = Magick::Image::read( "public/"+self.original_url ).first if file
        # puts "   Format: #{img.format}"
        # puts "   Geometry: #{img.columns}x#{img.rows}"
        # puts "   Class: " + case img.class_type
        #                         when Magick::DirectClass
        #                             "DirectClass"
        #                         when Magick::PseudoClass
        #                             "PseudoClass"
        #                     end
        # puts "   Depth: #{img.depth} bits-per-pixel"
        # puts "   Colors: #{img.number_colors}"
        # puts "   Filesize: #{img.filesize}"
        # puts "   Resolution: #{img.x_resolution.to_i}x#{img.y_resolution.to_i} "+
        #     "pixels/#{img.units == Magick::PixelsPerInchResolution ?
        #     "inch" : "centimeter"}"
        # if img.properties.length > 0
        #     puts "   Properties:"
        #     img.properties { |name,value|
        #         puts %Q|      #{name} = "#{value}"|
        #     }
        # end 
        throw "No image" if img.nil?
        throw "No size"  if self.size.nil?
        thumb = img.resize_to_fit((self.size / 2),(self.size / 2))
        base = img.resize_to_fit(self.size, self.size)
        thumb.write("public/products/"+prefix+"/thumb_"+self.filename)
        self.thumb_url = "products/"+prefix+"/thumb_"+self.filename
        base.write("public/products/"+prefix+"/base_"+self.filename)
        self.url = "products/"+prefix+"/base_"+self.filename
        self.save
    end
    
    def get_csv_from_ftp(uri,filename,prefix)
        BasicSocket.do_not_reverse_lookup = true
        nf = URI(URI.encode(uri))
        ftp = Net::FTP.new
        puts uri
        begin
        ftp.connect(nf.host,21)
        ftp.login(nf.user,nf.password)
        ftp.passive = true
       
        filename = "public/products/"+prefix+"/original_"+ filename
        puts nf.path
        ftp.getbinaryfile(URI.decode(nf.path),filename)
        rescue Exception => exc
                logger.error exc.message
                ftp.close
                return nil
        end
        ftp.close
        filename = nf.path.split("/").last
        return filename
    end
    
    def self.create_folders_for_images
        path ="public/products/"
        Dir.mkdir(path) unless File.exists?(path)
        1000.times do |i|
            num= i.to_s.rjust(3, '0')  
            puts num
            Dir.mkdir(path+num) unless File.exists?(path+num)

       end
    end
    
    def self.change_url_format
        Image.all.each do |i|
           i.thumb_url = i.thumb_url.split("/")[3..100].join('/')
           i.original_url = i.original_url.split("/")[3..100].join('/')
           i.url = i.url.split("/")[3..100].join('/')
           i.save
        end
        
    end
    def self.delete_not_existed_images
        ids =[]
       Image.all.pluck("id","url").each do |i,o|
           if !(File.exist? "public/"+o )
               
               ids << i
           end
       end
       
       Image.where(:id => ids).delete_all
    puts "deleted " +ids.size.to_s
    end

end
