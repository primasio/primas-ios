//
//  ArticleDetailModel.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import Foundation

class ArticleDetailModel {
    var title: String
    var content: String

    var username: String
    var userImageUrl: String

    var createdAt: Int

    var shared: Int
    var transfered: Int
    var stared: Int
    var DNA: String

    init(_ title: String, _ content: String, _ username: String, _ userImageUrl: String, _ createdAt: Int, _ shared: Int, _ transfered: Int, _ stared: Int, _ DNA: String ) {
      self.title = title
      self.content = content
      self.username = username
      self.userImageUrl = userImageUrl
      self.createdAt = createdAt
      self.shared = shared
      self.transfered = transfered
      self.stared = stared
      self.DNA = DNA
    }

    static func generateTestData() -> ArticleDetailModel {
      return ArticleDetailModel("一千元人民币在越南可以花多久？",
        "<p><strong>【猎云网（微信：<span class=\"pop-erweima\"><a href=\"javascript:;\">ilieyun</a><span class=\"poperweima\"><img src=\"http://cdnwww.lieyunwang.com/themes/default/images/theme/company_code.jpg\" width=100 alt=\"\"></span></span>）上海】7月17日报道（文/元杰）</strong></p><p>不可否认，技术的发展降低了信息传播的门槛，提升了信息传播的速度和广度。但与此同时，低门槛的多次传播也稀释了信息的价值，盗版、劣质信息充斥网络平台。</p><p>为了解决这些问题，来自上海的七印科技先后推出了商业化的版权保护服务平台“原本”（<a href=\"http://yuanben.io\" target=\"_blank\">yuanben.io</a>）和开源的的内容分发、推荐和交易平台Primas（<a href=\"http://primas.io\" target=\"_blank\">primas.io</a>）。<strong>它们都基于区块链技术，利用了其去中心化、数据不可篡改、可溯源的特性，让数字内容成为可以量化控制、流转交易的数字资产，帮助内容创造者实现有效的版权保护和合理的内容变现。</strong></p><h2>原本：用区块链保护版权，从根源终结抄袭</h2><p>原本是七印科技在去年推出的一款产品，主要为内容原创机构或个人提供版权保护服务，目标客户包括杂志社、报社、原创图片库、原创自媒体、网站等。</p><p>创始人甘露介绍，凡是使用原本服务的内容原创机构或个人所生产的每一个内容都会自动生成一个数字DNA作为全网唯一的作品身份标识，从而实现跨平台原创证明，为后续侵权检测和维权提供基础。</p><p>原本每天会通过去中心化爬虫工具检测全网侵权转载行为，为客户生成一份全网侵权检测分析报告，留存侵权证据。同时，原本接入了公证处、律所等维权服务机构，让证据具有法律效力，实现了一站式的版权保护服务，帮助客户降低维权成本。</p><p><a href=\"http://yuanben.io\" target=\"_blank\"><img class=\"aligncenter wp-image-338217\" src=\"http://cdn.lieyunwang.com/wp-content/uploads/2017/07/6b4f228048c9d4d.png?imageMogr2/thumbnail/400x/strip/interlace/1/quality/80/format/jpg\" alt=\"搜狗截图20170717103259\" width=\"1024\" height=\"447\" /></a></p><p>由于DNA信息包含作品授权信息，原本也提升了内容转载授权和版权交易的效率。具体而言，原创作者在发布内容时可以设置转载授权方式，可以选择免费也可以设置任意商业授权的价格。转载者如果有转载需求就可以通过DNA信息一键完成内容溯源或者付款交易。目前原本支持支付宝和微信支付。</p><p>除了版权保护功能，数字DNA可溯源的特点也能在一定程度上避免信息在多次传播过程中的“变质”问题。<strong>读者可以随时调出信息最原始出处，获取未被修改的原始信息。</strong></p><p>据了解，目前使用原本的客户已有二十多家。原本主要通过收取版权交易佣金获利。而未来，原本也在考虑通过内容大数据变现。</p><h2>Primas：去中心化的内容推荐，颠覆今日头条</h2><p>解决了困扰内容生产者的版权问题，原本的团队又注意到了信息消费者面临的困境：信息过剩。除了盗版问题，由于信息碎片化严重、中心化信息聚合推荐平台对内容展示的人为干预，以及营销信息泛滥，读者获取到的信息真假难辨、质量参差不齐，给信息消费者带来了困扰。</p><p>于是，在原本之外，七印科技又推出了Primas。</p><p>甘露介绍，这是一款<strong>完全开源的内容发布、推荐和交易平台，借助区块链技术赋予原创内容与质量挂钩的价值，从而改变现有内容市场格局，解决优质内容难以识别、传播和变现的问题。</strong></p><p><a href=\"http://primas.io\" target=\"_blank\"><img class=\" size-medium wp-image-338228 aligncenter\" src=\"http://cdn.lieyunwang.com/wp-content/uploads/2017/07/262bec6eda86e02-1024x683.png?imageMogr2/thumbnail/400x/strip/interlace/1/quality/80/format/jpg\" alt=\"微信图片_20170717113622\" width=\"1024\" height=\"683\" /></a></p><p>具体而言，Primas做了三件事：</p><p>其一：借鉴原本的原创内容版权保护机制，Primas给内容和用户唯一的数字身份：<strong>Primas DNA。</strong>透过这个DNA，用户可以知道谁在何时创建了这个信息，谁又在何时做出了怎样的修改。这些信息都会被写入区块链存证。同时Primas借助智能合约实现快速转载授权，借助Hawkeye实现全网监控。</p><p>其二，在Primas DNA的基础上，Primas建立起<strong>内容价值评价体系和用户信用评价体系</strong>。其中内容评价不再单纯依赖点击量（PV），而是由社会化推荐、传播广度、原创者信用等元素综合决定，从深度和广度两个方面全面衡量内容的价值，按照读者付出的成本从低到高可以排序为点击、点赞、评论、转发、转载。用户信用评价则由用户发布内容的数量、质量和账户代币数量共同决定。</p><p>其三，建立<strong>去中心化的内容社会化推荐机制和社群经济网络。</strong>在 Primas 平台上，用户可以选择自己感兴趣的圈子，并自动组建成社群，所有的社群都由用户自治，任何用户发布的内容都会优先在圈子里展示，而用户优先看到也是自己圈子里的内容，类似微信朋友圈。Primas由此达到去中心化的目的。甘露介绍，Primas所有和内容展示相关的算法都是开源的，用户可以参与优化。从而确保不会被任何中心化的算法所操控。</p><p>值得一提的是，第三方内容平台也可以直接将Primas圈子接入自家平台，快速建立垂直的内容社区。“比如某个母婴产品App可以加入Primas的母婴内容社群，将圈子内容展示在自己的平台上。而这些也都是完全开源的。”甘露表示，Primas是区块链对现有架构的颠覆，本身不是做产品或者商业化的公司，而是一个开源的社区。社区里有开发者、创作者等都是社区的成员、产品的用户，同时更是社区的股东，所有的人共同努力促进社区的发展和壮大。</p><p><img class=\"aligncenter wp-image-338224\" src=\"http://cdn.lieyunwang.com/wp-content/uploads/2017/07/ab645970048d5a1.png?imageMogr2/thumbnail/400x/strip/interlace/1/quality/80/format/jpg\" alt=\"intro04\" width=\"600\" height=\"419\" /></p><p>Primas 的底层架构在以太坊(Ethereum)上，关键逻辑使用智能合约实现，包括Primas DNA在内的核心数据也使用智能合约写入区块链，而文字、图片等内容数据则存储在IPFS中，从而避免挤占区块链资源，降低其数据处理能力。</p><p>Primas所使用的的数字代币名为Primas Token，简称PST。原创内容价值由PST体现，Prima则结合区块链技术和发行PST的方式建立起一套经济激励体系，以此来激发社区运行活力。甘露介绍，PST每年都会增发一部分作为奖池，用于对优质内容、优质社群、优质推荐、转载标记进行奖励。而PST增发的比例逐年递减，直至不再增发。内容创作者在获取内容发布权时，账号需要锁定一部分PST，并会在7 天后释放，从而达到防止内容水化，保护高质量内容的目的。一旦某些内容被举报侵权抄袭，并经Primas用户社区选举出的若干个验证者确认，系统会直接扣除侵权者账户内锁定的PST，同时反映在侵权者的信用系统里，影响侵权者以后的内容发布和激励获取。</p><p>据了解，Primas初始发行 PST 共 1 亿个，其中 5100 万将在8月1日开始 ICO （Initial Ccoin Offering，数字加密币众筹）阶段分发给社区。</p><h2>核心：写在区块链上的DNA</h2><p>猎云网（微信：<span class=\"pop-erweima\"><a href=\"javascript:;\">ilieyun</a><span class=\"poperweima\"><img src=\"http://cdnwww.lieyunwang.com/themes/default/images/theme/company_code.jpg\" width=100 alt=\"\"></span></span>）了解到，无论是“原本”还是Primas，其运作的核心都是赋予信息独一无二的数字识别身份，他们称之为DNA。<strong>这是一个绑定在区块链上的去中心化数据，一旦写入区块链也不可篡改。</strong></p><p><img class=\"aligncenter wp-image-338220\" src=\"http://cdn.lieyunwang.com/wp-content/uploads/2017/07/87a3ebfcaa56be8.png?imageMogr2/thumbnail/400x/strip/interlace/1/quality/80/format/jpg\" alt=\"intro06\" width=\"600\" height=\"492\" /></p><p>甘露介绍，这个DNA综合了作者身份秘钥、作品发布时间、内容指纹数据、授权方式等信息。因为这个DNA数据全网唯一且不可篡改，所以它既能证明原创作者，也能在作品多次转载以后证明文章最原始的出处。<strong>这就在原本不具备信任关系的作者、传播者和读者之间建立了唯一可信的信任关系，大家在信息生产、传播过程中的关系一目了然。进而作品授权、转载、推荐、交易等行为也就变得可控。</strong></p><p>不过，虽然DNA数据唯一不可更改，但它却可以被删除。对此，七印科技开发了名为Hawkeye（鹰眼）的全网转载监控系统作为辅助。这个系统<strong>利用了网络爬虫和自然语言处理技术，能够在全网范围内自动查找侵权文章。</strong>甘露表示，即使内容被修改、DNA数据丢失，Hawkeye也能通过相似度对比将它们抓出来。</p><p><img class=\"aligncenter wp-image-338222\" src=\"http://cdn.lieyunwang.com/wp-content/uploads/2017/07/b5b6b2d73121868.png?imageMogr2/thumbnail/400x/strip/interlace/1/quality/80/format/jpg\" alt=\"intro03\" width=\"600\" height=\"521\" /></p><p>七印科技的核心团队除了对区块链技术有深入的研究以外，还有多年手机浏览器的开发和运营的经验，熟悉内容聚合和智能推荐业务。他们于2016 年获得万向区块链和分布式资本的投资。</p>",
        "胡适", "https://img3.doubanio.com/icon/u36356293-3.jpg", 1499747389, 2800, 39999, 66666
        , "ZHDSLA")
    }
}
