require "mailcheck/version"

class Mailcheck

  THRESHOLD = 3

  DOMAINS = ['yahoo.com', 'google.com', 'hotmail.com', 'gmail.com', 'me.com', 'aol.com', 'mac.com', 'live.com', 'comcast.net', 'googlemail.com', 'msn.com', 'hotmail.co.uk', 'yahoo.co.uk', 'facebook.com', 'verizon.net', 'sbcglobal.net', 'att.net', 'gmx.com', 'mail.com']

  TOP_LEVEL_DOMAINS = ['co.uk', 'com', 'net', 'org', 'info', 'edu', 'gov', 'mil']

  def initialize(opts={})
    @domains = opts[:domains] || DOMAINS
    @top_level_domains = opts[:top_level_domains] || TOP_LEVEL_DOMAINS
  end

  def suggest(email)
    email_parts = split_email(email.downcase)

    return false if email_parts == false

    closest_domain = find_closest_domain(email_parts[:domain], @domains)

    if closest_domain
      if closest_domain != email_parts[:domain]
        # The email address closely matches one of the supplied domains return a suggestion
        return { :address => email_parts[:address], :domain => closest_domain, :full => "#{email_parts[:address]}@#{closest_domain}" }
      end
    else
      # The email address does not closely match one of the supplied domains
      closest_top_level_domain = find_closest_domain(email_parts[:top_level_domain], @top_level_domains)
      if email_parts[:domain] && closest_top_level_domain && closest_top_level_domain != email_parts[:top_level_domain]
        # The email address may have a mispelled top-level domain return a suggestion
        domain = email_parts[:domain]
        closest_domain = domain[0, domain.rindex(email_parts[:top_level_domain])] + closest_top_level_domain
        return { :address => email_parts[:address], :domain => closest_domain, :full => "#{email_parts[:address]}@#{closest_domain}" }
      end
    end
    # The email address exactly matches one of the supplied domains, does not closely
    # match any domain and does not appear to simply have a mispelled top-level domain,
    # or is an invalid email address do not return a suggestion.
    false
  end

  def find_closest_domain(domain, domains)
    min_dist = 99

    for i in 0...domains.length do
      if domain === domains[i]
        return domain
      end
      dist = sift_3distance(domain, domains[i])
      if dist < min_dist
        min_dist = dist
        closest_domain = domains[i]
      end
    end

    if min_dist <= THRESHOLD && closest_domain
      closest_domain
    else
      false
    end
  end

  def sift_3distance(s1, s2)
    # sift3: http:#siderite.blogspot.com/2007/04/super-fast-and-accurate-string-distance.html

    c = 0
    offset1 = 0
    offset2 = 0
    lcs = 0
    max_offset = 5

    while (c + offset1 < s1.length) && (c + offset2 < s2.length) do
      if s1[c + offset1] == s2[c + offset2]
        lcs += 1
      else
        offset1 = 0
        offset2 = 0
        for i in 0...max_offset do
          if c + i < s1.length && s1[c + i] == s2[c]
            offset1 = i
            break
          end
          if c + i < s2.length && s1[c] == s2[c + i]
            offset2 = i
            break
          end
        end
      end
      c += 1
    end
    return (s1.length + s2.length) / 2 - lcs
  end

  def split_email(email)

    parts = email.split('@')

    if parts.length < 2
      return false
    end

    for i in 0...parts.length do
      if parts[i] === ''
        return false
      end
    end

    domain = parts.pop
    domain_parts = domain.split('.')
    tld = ''

    if domain_parts.length == 0
      # The address does not have a top-level domain
      return false
    elsif domain_parts.length == 1
      # The address has only a top-level domain (valid under RFC)
      tld = domain_parts[0]
    else
      # The address has a domain and a top-level domain
      for i in 1...domain_parts.length do
        tld << "#{domain_parts[i]}."
      end
      if domain_parts.length >= 2
        tld = tld[0, tld.length - 1]
      end
    end

    {
      :top_level_domain => tld,
      :domain => domain,
      :address => parts.join('@')
    }
  end
end
