(function(c, l) {
    "function" === typeof define && define.amd ? define(["jquery"], function(m) {
        return l(m, c, c.document, c.Math)
    }) : "undefined" !== typeof exports ? module.exports = l(require("jquery"), c, c.document, c.Math) : l(jQuery, c, c.document, c.Math)
})("undefined" !== typeof window ? window : this, function(c, l, m, p, H) {
    var n = c(l),
        w = c(m);
    c.fn.fullpage = function(d) {
        function La() {
            h.css({
                height: "80%",
                position: "relative"
            });
            h.addClass("fullpage-wrapper");
            c("html").addClass("fp-enabled");
            d.css3 && (d.css3 = Ma());
            d.anchors.length || (d.anchors = c("[data-anchor]").map(function() {
                return c(this).data("anchor").toString()
            }).get());
            e.setAllowScrolling(!0);
            h.removeClass("fp-destroyed");
            Na();
            c(".fp-section").each(function(a) {
                var b = c(this),
                    e = b.find(".fp-slide"),
                    h = e.length;
                a || 0 !== c(".fp-section.active").length || b.addClass("active");
                b.css("height", q + "px");
                d.paddingTop && b.css("padding-top", d.paddingTop);
                d.paddingBottom && b.css("padding-bottom", d.paddingBottom);
                "undefined" !== typeof d.sectionsColor[a] && b.css("background-color", d.sectionsColor[a]);
                "undefined" !== typeof d.anchors[a] && (b.attr("data-anchor", d.anchors[a]), b.hasClass("active") && I(d.anchors[a], a));
                d.menu && d.css3 && c(d.menu).closest(".fullpage-wrapper").length && c(d.menu).appendTo(r);
                0 < h ? Oa(b, e, h) : d.verticalCentered && ia(b)
            });
            e.setAutoScrolling(d.autoScrolling, "internal");
            var a = c(".fp-section.active").find(".fp-slide.active");
            a.length && (0 !== c(".fp-section.active").index(".fp-section") || 0 === c(".fp-section.active").index(".fp-section") && 0 !== a.index()) && U(a);
            d.fixedElements && d.css3 && c(d.fixedElements).appendTo(r);
            d.navigation && Pa();
            d.scrollOverflow ? ("complete" === m.readyState && ja(), n.on("load", ja)) : ka();
            la();
            if (!d.animateAnchor && (a = l.location.hash.replace("#", "").split("/")[0], a.length)) {
                var b = c('[data-anchor="' + a + '"]');
                b.length && (d.autoScrolling ? x(b.position().top) : (x(0), t.scrollTop(b.position().top)), I(a, null), c.isFunction(d.afterLoad) && d.afterLoad.call(b, a, b.index(".fp-section") + 1), b.addClass("active").siblings().removeClass("active"))
            }
            ma();
            n.on("load", function() {
                var a = l.location.hash.replace("#", "").split("/"),
                    b = a[0],
                    a = a[1];
                b && V(b, a)
            })
        }

        function Oa(a, b, g) {
            var f = 100 * g,
                e = 100 / g;
            b.wrapAll('<div class="fp-slidesContainer" />');
            b.parent().wrap('<div class="fp-slides" />');
            a.find(".fp-slidesContainer").css("width", f + "%");
            1 < g && (d.controlArrows && Qa(a), d.slidesNavigation && Ra(a, g));
            b.each(function(a) {
                c(this).css("width", e + "%");
                d.verticalCentered && ia(c(this))
            });
            a = a.find(".fp-slide.active");
            a.length && (0 !== c(".fp-section.active").index(".fp-section") || 0 === c(".fp-section.active").index(".fp-section") && 0 !== a.index()) ? U(a) : b.eq(0).addClass("active")
        }

        function Na() {
            c(d.sectionSelector).each(function() {
                c(this).addClass("fp-section")
            });
            c(d.slideSelector).each(function() {
                c(this).addClass("fp-slide")
            })
        }

        function Qa(a) {
            a.find(".fp-slides").after('<div class="fp-controlArrow fp-prev"></div><div class="fp-controlArrow fp-next"></div>');
            "#fff" != d.controlArrowColor && (a.find(".fp-controlArrow.fp-next").css("border-color", "transparent transparent transparent " + d.controlArrowColor), a.find(".fp-controlArrow.fp-prev").css("border-color", "transparent " + d.controlArrowColor + " transparent transparent"));
            d.loopHorizontal || a.find(".fp-controlArrow.fp-prev").hide()
        }

        function Pa() {
            r.append('<div id="fp-nav"><ul></ul></div>');
            var a = c("#fp-nav");
            a.addClass(function() {
                return d.showActiveTooltip ? "fp-show-active " + d.navigationPosition : d.navigationPosition
            });
            for (var b = 0; b < c(".fp-section").length; b++) {
                var g = "";
                d.anchors.length && (g = d.anchors[b]);
                var g = '<li><a href="#' + g + '"><span></span></a>',
                    f = d.navigationTooltips[b];
                "undefined" !== typeof f && "" !== f && (g += '<div class="fp-tooltip ' + d.navigationPosition + '">' + f + "</div>");
                g += "</li>";
                a.find("ul").append(g)
            }
            c("#fp-nav").css("margin-top", "-" + c("#fp-nav").height() / 2 + "px");
            c("#fp-nav").find("li").eq(c(".fp-section.active").index(".fp-section")).find("a").addClass("active")
        }

        function ja() {
            c(".fp-section").each(function() {
                var a = c(this).find(".fp-slide");
                a.length ? a.each(function() {
                    J(c(this))
                }) : J(c(this))
            });
            ka()
        }

        function ka() {
            var a = c(".fp-section.active"),
                b = a.find("SLIDES_WRAPPER"),
                g = a.find(".fp-scrollable");
            b.length && (g = b.find(".fp-slide.active"));
            g.mouseover();
            K(a);
            na(a);
            c.isFunction(d.afterLoad) && d.afterLoad.call(a, a.data("anchor"), a.index(".fp-section") + 1);
            c.isFunction(d.afterRender) && d.afterRender.call(h)
        }

        function oa() {
            var a;
            if (!d.autoScrolling || d.scrollBar) {
                for (var b = n.scrollTop(), g = 0, f = p.abs(b - m.querySelectorAll(".fp-section")[0].offsetTop), h = m.querySelectorAll(".fp-section"), k = 0; k < h.length; ++k) {
                    var l = p.abs(b - h[k].offsetTop);
                    l < f && (g = k, f = l)
                }
                a = c(h).eq(g)
            }
            if (!d.autoScrolling || d.scrollBar) {
                if (!a.hasClass("active") && !a.hasClass("fp-auto-height")) {
                    W = !0;
                    b = c(".fp-section.active");
                    g = b.index(".fp-section") + 1;
                    f = X(a);
                    h = a.data("anchor");
                    k = a.index(".fp-section") + 1;
                    l = a.find(".fp-slide.active");
                    if (l.length) var r = l.data("anchor"),
                    q = l.index();
                    y && (a.addClass("active").siblings().removeClass("active"), c.isFunction(d.onLeave) && d.onLeave.call(b, g, k, f), c.isFunction(d.afterLoad) && d.afterLoad.call(a, h, k), K(a), e.setFitToSection(!a.hasClass("fp-auto-height")), I(h, k - 1), d.anchors.length && (A = h, Y(q, r, h, k)));
                    clearTimeout(Z);
                    Z = setTimeout(function() {
                        W = !1
                    }, 100)
                }
                d.fitToSection && (clearTimeout(aa), aa = setTimeout(function() {
                    y && d.fitToSection && (c(".fp-section.active").is(a) && requestAnimFrame(function() {
                        v = !0
                    }), B(a), v = !1)
                }, d.fitToSectionDelay))
            }
        }

        function pa(a) {
            return a.find(".fp-slides").length ? a.find(".fp-slide.active").find(".fp-scrollable") : a.find(".fp-scrollable")
        }

        function L(a, b) {
            if (k.m[a]) {
                var d, c;
                "down" == a ? (d = "bottom", c = e.moveSectionDown) : (d = "top", c = e.moveSectionUp);
                if (0 < b.length)
                    if (d = "top" === d ? !b.scrollTop() : "bottom" === d ? b.scrollTop() + 1 + b.innerHeight() >= b[0].scrollHeight : void 0, d) c();
                    else return !0;
                    else c()
            }
        }

        function Sa(a) {
            var b = a.originalEvent;
            if (!qa(a.target) && ba(b)) {
                d.autoScrolling && a.preventDefault();
                a = c(".fp-section.active");
                var g = pa(a);
                y && !z && (b = ra(b), D = b.y, M = b.x, a.find(".fp-slides").length && p.abs(N - M) > p.abs(E - D) ? p.abs(N - M) > n.width() / 100 * d.touchSensitivity && (N > M ? k.m.right && e.moveSlideRight() : k.m.left && e.moveSlideLeft()) : d.autoScrolling && p.abs(E - D) > n.height() / 100 * d.touchSensitivity && (E > D ? L("down", g) : D > E && L("up", g)))
            }
        }

        function qa(a, b) {
            b = b || 0;
            var g = c(a).parent();
            return b < d.normalScrollElementTouchThreshold && g.is(d.normalScrollElements) ? !0 : b == d.normalScrollElementTouchThreshold ? !1 : qa(g, ++b)
        }

        function ba(a) {
            return "undefined" === typeof a.pointerType || "mouse" != a.pointerType
        }

        function Ta(a) {
            a = a.originalEvent;
            d.fitToSection && t.stop();
            ba(a) && (a = ra(a), E = a.y, N = a.x)
        }

        function sa(a, b) {
            for (var d = 0, c = a.slice(p.max(a.length - b, 1)), e = 0; e < c.length; e++) d += c[e];
            return p.ceil(d / b)
        }

        function u(a) {
            var b = (new Date).getTime();
            if (d.autoScrolling && !O) {
                a = a || l.event;
                var g = a.wheelDelta || -a.deltaY || -a.detail,
                    f = p.max(-1, p.min(1, g));
                149 < C.length && C.shift();
                C.push(p.abs(g));
                d.scrollBar && (a.preventDefault ? a.preventDefault() : a.returnValue = !1);
                a = c(".fp-section.active");
                a = pa(a);
                g = b - ta;
                ta = b;
                200 < g && (C = []);
                y && (b = sa(C, 10), g = sa(C, 70), b >= g && (0 > f ? L("down", a) : L("up", a)));
                return !1
            }
            d.fitToSection && t.stop()
        }

        function ua(a) {
            var b = c(".fp-section.active").find(".fp-slides"),
                g = b.find(".fp-slide").length;
            if (!(!b.length || z || 2 > g)) {
                var g = b.find(".fp-slide.active"),
                    f = null,
                    f = "prev" === a ? g.prev(".fp-slide") : g.next(".fp-slide");
                if (!f.length) {
                    if (!d.loopHorizontal) return;
                    f = "prev" === a ? g.siblings(":last") : g.siblings(":first")
                }
                z = !0;
                F(b, f)
            }
        }

        function va() {
            c(".fp-slide.active").each(function() {
                U(c(this), "internal")
            })
        }

        function B(a, b, g) {
            requestAnimFrame(function() {
                var f = a.position();
                if ("undefined" !== typeof f) {
                    var e = a.hasClass("fp-auto-height") ? f.top == 0 ? 0 : f.top - q + a.height() : f.top,
                        f = {
                            element: a,
                            callback: b,
                            isMovementUp: g,
                            dest: f,
                            dtop: e,
                            yMovement: X(a),
                            anchorLink: a.data("anchor"),
                            sectionIndex: a.index(".fp-section"),
                            activeSlide: a.find(".fp-slide.active"),
                            activeSection: c(".fp-section.active"),
                            leavingSection: c(".fp-section.active").index(".fp-section") + 1,
                            localIsResizing: v
                        };
                    if (!(f.activeSection.is(a) && !v || d.scrollBar && n.scrollTop() === f.dtop && !a.hasClass("fp-auto-height"))) {
                        if (f.activeSlide.length) var h = f.activeSlide.data("anchor"),
                        k = f.activeSlide.index();
                        d.autoScrolling && d.continuousVertical && "undefined" !== typeof f.isMovementUp && (!f.isMovementUp && "up" == f.yMovement || f.isMovementUp && "down" == f.yMovement) && (f.isMovementUp ? c(".fp-section.active").before(f.activeSection.nextAll(".fp-section")) : c(".fp-section.active").after(f.activeSection.prevAll(".fp-section").get().reverse()), x(c(".fp-section.active").position().top), va(), f.wrapAroundElements = f.activeSection, f.dest = f.element.position(), f.dtop = f.dest.top, f.yMovement = X(f.element));
                        if (c.isFunction(d.onLeave) && !f.localIsResizing) {
                            if (!1 === d.onLeave.call(f.activeSection, f.leavingSection, f.sectionIndex + 1, f.yMovement)) return;
                            Ua(f.activeSection)
                        }
                        a.addClass("active").siblings().removeClass("active");
                        K(a);
                        y = !1;
                        Y(k, h, f.anchorLink, f.sectionIndex);
                        Va(f);
                        A = f.anchorLink;
                        I(f.anchorLink, f.sectionIndex)
                    }
                }
            })
        }

        function Va(a) {
            if (d.css3 && d.autoScrolling && !d.scrollBar) wa("translate3d(0px, -" + a.dtop + "px, 0px)", !0), d.scrollingSpeed ? ca = setTimeout(function() {
                da(a)
            }, d.scrollingSpeed) : da(a);
            else {
                var b = Wa(a);
                c(b.element).animate(b.options, d.scrollingSpeed, d.easing).promise().done(function() {
                    da(a)
                })
            }
        }

        function Wa(a) {
            var b = {};
            d.autoScrolling && !d.scrollBar ? (b.options = {
                top: -a.dtop
            }, b.element = ".fullpage-wrapper") : (b.options = {
                scrollTop: a.dtop
            }, b.element = "html, body");
            return b
        }

        function da(a) {
            a.wrapAroundElements && a.wrapAroundElements.length && (a.isMovementUp ? c(".fp-section:first").before(a.wrapAroundElements) : c(".fp-section:last").after(a.wrapAroundElements), x(c(".fp-section.active").position().top), va());
            a.element.find(".fp-scrollable").mouseover();
            e.setFitToSection(!a.element.hasClass("fp-auto-height"));
            c.isFunction(d.afterLoad) && !a.localIsResizing && d.afterLoad.call(a.element, a.anchorLink, a.sectionIndex + 1);
            na(a.element);
            y = !0;
            c.isFunction(a.callback) && a.callback.call(this)
        }

        function K(a) {
            var b = a.find(".fp-slide.active");
            b.length && (a = c(b));
            a.find("img[data-src], source[data-src], audio[data-src]").each(function() {
                c(this).attr("src", c(this).data("src"));
                c(this).removeAttr("data-src");
                c(this).is("source") && c(this).closest("video").get(0).load()
            })
        }

        function na(a) {
            a.find("video, audio").each(function() {
                var a = c(this).get(0);
                a.hasAttribute("autoplay") && "function" === typeof a.play && a.play()
            })
        }

        function Ua(a) {
            a.find("video, audio").each(function() {
                var a = c(this).get(0);
                a.hasAttribute("data-ignore") || "function" !== typeof a.pause || a.pause()
            })
        }

        function xa() {
            if (!W && !d.lockAnchors) {
                var a = l.location.hash.replace("#", "").split("/"),
                    b = a[0],
                    a = a[1];
                if (b.length) {
                    var c = "undefined" === typeof A,
                        f = "undefined" === typeof A && "undefined" === typeof a && !z;
                    (b && b !== A && !c || f || !z && ea != a) && V(b, a)
                }
            }
        }

        function Xa(a) {
            y && (a.pageY < P ? e.moveSectionUp() : a.pageY > P && e.moveSectionDown());
            P = a.pageY
        }

        function F(a, b) {
            var g = b.position(),
                f = b.index(),
                e = a.closest(".fp-section"),
                h = e.index(".fp-section"),
                k = e.data("anchor"),
                l = e.find(".fp-slidesNav"),
                m = ya(b),
                n = v;
            if (d.onSlideLeave) {
                var r = e.find(".fp-slide.active"),
                    q = r.index(),
                    t;
                t = q == f ? "none" : q > f ? "left" : "right";
                if (!n && "none" !== t && c.isFunction(d.onSlideLeave) && !1 === d.onSlideLeave.call(r, k, h + 1, q, t, f)) {
                    z = !1;
                    return
                }
            }
            b.addClass("active").siblings().removeClass("active");
            n || K(b);
            !d.loopHorizontal && d.controlArrows && (e.find(".fp-controlArrow.fp-prev").toggle(0 !== f), e.find(".fp-controlArrow.fp-next").toggle(!b.is(":last-child")));
            e.hasClass("active") && Y(f, m, k, h);
            var u = function() {
                n || c.isFunction(d.afterSlideLoad) && d.afterSlideLoad.call(b, k, h + 1, m, f);
                z = !1
            };
            d.css3 ? (g = "translate3d(-" + p.round(g.left) + "px, 0px, 0px)", za(a.find(".fp-slidesContainer"), 0 < d.scrollingSpeed).css(Aa(g)), fa = setTimeout(function() {
                u()
            }, d.scrollingSpeed, d.easing)) : a.animate({
                scrollLeft: p.round(g.left)
            }, d.scrollingSpeed, d.easing, function() {
                u()
            });
            l.find(".active").removeClass("active");
            l.find("li").eq(f).find("a").addClass("active")
        }

        function Ba() {
            la();
            if (Q) {
                var a = c(m.activeElement);
                a.is("textarea") || a.is("input") || a.is("select") || (a = n.height(), p.abs(a - ga) > 20 * p.max(ga, a) / 100 && (e.reBuild(!0), ga = a))
            } else clearTimeout(ha), ha = setTimeout(function() {
                e.reBuild(!0)
            }, 350)
        }

        function la() {
            var a = d.responsive || d.responsiveWidth,
                b = d.responsiveHeight;
            a && e.setResponsive(n.width() < a);
            b && (h.hasClass("fp-responsive") || e.setResponsive(n.height() < b))
        }

        function za(a) {
            var b = "all " + d.scrollingSpeed + "ms " + d.easingcss3;
            a.removeClass("fp-notransition");
            return a.css({
                "-webkit-transition": b,
                transition: b
            })
        }

        function Ya(a, b) {
            if (825 > a || 900 > b) {
                var d = p.min(100 * a / 825, 100 * b / 900).toFixed(2);
                r.css("font-size", d + "%")
            } else r.css("font-size", "100%")
        }

        function I(a, b) {
            d.menu && (c(d.menu).find(".active").removeClass("active"), c(d.menu).find('[data-menuanchor="' + a + '"]').addClass("active"));
            d.navigation && (c("#fp-nav").find(".active").removeClass("active"), a ? c("#fp-nav").find('a[href="#' + a + '"]').addClass("active") : c("#fp-nav").find("li").eq(b).find("a").addClass("active"))
        }

        function X(a) {
            var b = c(".fp-section.active").index(".fp-section");
            a = a.index(".fp-section");
            return b == a ? "none" : b > a ? "up" : "down"
        }

        function J(a) {
            a.css("overflow", "hidden");
            var b = a.closest(".fp-section"),
                c = a.find(".fp-scrollable"),
                f;
            c.length ? f = c.get(0).scrollHeight : (f = a.get(0).scrollHeight, d.verticalCentered && (f = a.find(".fp-tableCell").get(0).scrollHeight));
            b = q - parseInt(b.css("padding-bottom")) - parseInt(b.css("padding-top"));
            f > b ? c.length ? c.css("height", b + "px").parent().css("height", b + "px") : (d.verticalCentered ? a.find(".fp-tableCell").wrapInner('<div class="fp-scrollable" />') : a.wrapInner('<div class="fp-scrollable" />'), a.find(".fp-scrollable").slimScroll({
                allowPageScroll: !0,
                height: b + "px",
                size: "10px",
                alwaysVisible: !0
            })) : Ca(a);
            a.css("overflow", "")
        }

        function Ca(a) {
            a.find(".fp-scrollable").children().first().unwrap().unwrap();
            a.find(".slimScrollBar").remove();
            a.find(".slimScrollRail").remove()
        }

        function ia(a) {
            a.addClass("fp-table").wrapInner('<div class="fp-tableCell" style="height:' + Da(a) + 'px;" />')
        }

        function Da(a) {
            var b = q;
            if (d.paddingTop || d.paddingBottom) b = a, b.hasClass("fp-section") || (b = a.closest(".fp-section")), a = parseInt(b.css("padding-top")) + parseInt(b.css("padding-bottom")), b = q - a;
            return b
        }

        function wa(a, b) {
            b ? za(h) : h.addClass("fp-notransition");
            h.css(Aa(a));
            setTimeout(function() {
                h.removeClass("fp-notransition")
            }, 10)
        }

        function Ea(a) {
            var b = c('.fp-section[data-anchor="' + a + '"]');
            b.length || (b = c(".fp-section").eq(a - 1));
            return b
        }

        function V(a, b) {
            var d = Ea(a);
            "undefined" === typeof b && (b = 0);
            a === A || d.hasClass("active") ? Fa(d, b) : B(d, function() {
                Fa(d, b)
            })
        }

        function Fa(a, b) {
            if ("undefined" !== typeof b) {
                var d = a.find(".fp-slides"),
                    c;
                c = a.find(".fp-slides");
                var e = c.find('.fp-slide[data-anchor="' + b + '"]');
                e.length || (e = c.find(".fp-slide").eq(b));
                c = e;
                c.length && F(d, c)
            }
        }

        function Ra(a, b) {
            a.append('<div class="fp-slidesNav"><ul></ul></div>');
            var c = a.find(".fp-slidesNav");
            c.addClass(d.slidesNavPosition);
            for (var f = 0; f < b; f++) c.find("ul").append('<li><a href="#"><span></span></a></li>');
            c.css("margin-left", "-" + c.width() / 2 + "px");
            c.find("li").first().find("a").addClass("active")
        }

        function Y(a, b, c, f) {
            f = "";
            d.anchors.length && !d.lockAnchors && (a ? ("undefined" !== typeof c && (f = c), "undefined" === typeof b && (b = a), ea = b, Ga(f + "/" + b)) : ("undefined" !== typeof a && (ea = b), Ga(c)));
            ma()
        }

        function Ga(a) {
            if (d.recordHistory) location.hash = a;
            else if (Q || R) history.replaceState(H, H, "#" + a);
            else {
                var b = l.location.href.split("#")[0];
                l.location.replace(b + "#" + a)
            }
        }

        function ya(a) {
            var b = a.data("anchor");
            a = a.index();
            "undefined" === typeof b && (b = a);
            return b
        }

        function ma() {
            var a = c(".fp-section.active"),
                b = a.find(".fp-slide.active"),
                e = a.data("anchor"),
                f = ya(b),
                a = a.index(".fp-section"),
                a = String(a);
            d.anchors.length && (a = e);
            b.length && (a = a + "-" + f);
            a = a.replace("/", "-").replace("#", "");
            r[0].className = r[0].className.replace(RegExp("\\b\\s?fp-viewing-[^\\s]+\\b", "g"), "");
            r.addClass("fp-viewing-" + a)
        }

        function Ma() {
            var a = m.createElement("p"),
                b, c = {
                    webkitTransform: "-webkit-transform",
                    OTransform: "-o-transform",
                    msTransform: "-ms-transform",
                    MozTransform: "-moz-transform",
                    transform: "transform"
                };
            m.body.insertBefore(a, null);
            for (var d in c) a.style[d] !== H && (a.style[d] = "translate3d(1px,1px,1px)", b = l.getComputedStyle(a).getPropertyValue(c[d]));
            m.body.removeChild(a);
            return b !== H && 0 < b.length && "none" !== b
        }

        function Za() {
            if (Q || R) {
                var a = Ha();
                c(".fullpage-wrapper").off("touchstart " + a.down).on("touchstart " + a.down, Ta);
                c(".fullpage-wrapper").off("touchmove " + a.move).on("touchmove " + a.move, Sa)
            }
        }

        function $a() {
            if (Q || R) {
                var a = Ha();
                c(".fullpage-wrapper").off("touchstart " + a.down);
                c(".fullpage-wrapper").off("touchmove " + a.move)
            }
        }

        function Ha() {
            return l.PointerEvent ? {
                down: "pointerdown",
                move: "pointermove"
            } : {
                down: "MSPointerDown",
                move: "MSPointerMove"
            }
        }

        function ra(a) {
            var b = [];
            b.y = "undefined" !== typeof a.pageY && (a.pageY || a.pageX) ? a.pageY : a.touches[0].pageY;
            b.x = "undefined" !== typeof a.pageX && (a.pageY || a.pageX) ? a.pageX : a.touches[0].pageX;
            R && ba(a) && d.scrollBar && (b.y = a.touches[0].pageY, b.x = a.touches[0].pageX);
            return b
        }

        function U(a, b) {
            e.setScrollingSpeed(0, "internal");
            "undefined" !== typeof b && (v = !0);
            F(a.closest(".fp-slides"), a);
            "undefined" !== typeof b && (v = !1);
            e.setScrollingSpeed(G.scrollingSpeed, "internal")
        }

        function x(a) {
            d.scrollBar ? h.scrollTop(a) : d.css3 ? wa("translate3d(0px, -" + a + "px, 0px)", !1) : h.css("top", -a)
        }

        function Aa(a) {
            return {
                "-webkit-transform": a,
                "-moz-transform": a,
                "-ms-transform": a,
                transform: a
            }
        }

        function Ia(a, b, c) {
            switch (b) {
                case "up":
                    k[c].up = a;
                    break;
                case "down":
                    k[c].down = a;
                    break;
                case "left":
                    k[c].left = a;
                    break;
                case "right":
                    k[c].right = a;
                    break;
                case "all":
                    "m" == c ? e.setAllowScrolling(a) : e.setKeyboardScrolling(a)
            }
        }

        function ab() {
            x(0);
            c("#fp-nav, .fp-slidesNav, .fp-controlArrow").remove();
            c(".fp-section").css({
                height: "",
                "background-color": "",
                padding: ""
            });
            c(".fp-slide").css({
                width: ""
            });
            h.css({
                height: "",
                position: "",
                "-ms-touch-action": "",
                "touch-action": ""
            });
            t.css({
                overflow: "",
                height: ""
            });
            c("html").removeClass("fp-enabled");
            c.each(r.get(0).className.split(/\s+/), function(a, b) {
                0 === b.indexOf("fp-viewing") && r.removeClass(b)
            });
            c(".fp-section, .fp-slide").each(function() {
                Ca(c(this));
                c(this).removeClass("fp-table active")
            });
            h.addClass("fp-notransition");
            h.find(".fp-tableCell, .fp-slidesContainer, .fp-slides").each(function() {
                c(this).replaceWith(this.childNodes)
            });
            t.scrollTop(0)
        }

        function S(a, b, c) {
            d[a] = b;
            "internal" !== c && (G[a] = b)
        }

        function T(a, b) {
            console && console[a] && console[a]("fullPage: " + b)
        }
        var t = c("html, body"),
            r = c("body"),
            e = c.fn.fullpage;
        d = c.extend({
            menu: !1,
            anchors: [],
            lockAnchors: !1,
            navigation: !1,
            navigationPosition: "right",
            navigationTooltips: [],
            showActiveTooltip: !1,
            slidesNavigation: !1,
            slidesNavPosition: "bottom",
            scrollBar: !1,
            css3: !0,
            scrollingSpeed: 700,
            autoScrolling: !0,
            fitToSection: !0,
            fitToSectionDelay: 1E3,
            easing: "easeInOutCubic",
            easingcss3: "ease",
            loopBottom: !1,
            loopTop: !1,
            loopHorizontal: !0,
            continuousVertical: !1,
            normalScrollElements: null,
            scrollOverflow: !1,
            touchSensitivity: 5,
            normalScrollElementTouchThreshold: 5,
            keyboardScrolling: !0,
            animateAnchor: !0,
            recordHistory: !0,
            controlArrows: !0,
            controlArrowColor: "#fff",
            verticalCentered: !0,
            resize: !1,
            sectionsColor: [],
            paddingTop: 0,
            paddingBottom: 0,
            fixedElements: null,
            responsive: 0,
            responsiveWidth: 0,
            responsiveHeight: 0,
            sectionSelector: ".section",
            slideSelector: ".slide",
            afterLoad: null,
            onLeave: null,
            afterRender: null,
            afterResize: null,
            afterReBuild: null,
            afterSlideLoad: null,
            onSlideLeave: null
        }, d);
        (function() {
            d.continuousVertical && (d.loopTop || d.loopBottom) && (d.continuousVertical = !1, T("warn", "Option `loopTop/loopBottom` is mutually exclusive with `continuousVertical`; `continuousVertical` disabled"));
            d.scrollBar && d.scrollOverflow && T("warn", "Option `scrollBar` is mutually exclusive with `scrollOverflow`. Sections with scrollOverflow might not work well in Firefox");
            d.continuousVertical && d.scrollBar && (d.continuousVertical = !1, T("warn", "Option `scrollBar` is mutually exclusive with `continuousVertical`; `continuousVertical` disabled"));
            c.each(d.anchors, function(a, b) {
                (c("#" + b).length || c('[name="' + b + '"]').length) && T("error", "data-anchor tags can not have the same value as any `id` element on the site (or `name` element for IE).")
            })
        })();
        c.extend(c.easing, {
            easeInOutCubic: function(a, b, c, d, e) {
                return 1 > (b /= e / 2) ? d / 2 * b * b * b + c : d / 2 * ((b -= 2) * b * b + 2) + c
            }
        });
        c.extend(c.easing, {
            easeInQuart: function(a, b, c, d, e) {
                return d * (b /= e) * b * b * b + c
            }
        });
        e.setAutoScrolling = function(a, b) {
            S("autoScrolling", a, b);
            var g = c(".fp-section.active");
            d.autoScrolling && !d.scrollBar ? (t.css({
                overflow: "hidden",
                height: "100%"
            }), e.setRecordHistory(d.recordHistory, "internal"), h.css({
                "-ms-touch-action": "none",
                "touch-action": "none"
            }), g.length && x(g.position().top)) : (t.css({
                overflow: "visible",
                height: "initial"
            }), e.setRecordHistory(!1, "internal"), h.css({
                "-ms-touch-action": "",
                "touch-action": ""
            }), x(0), g.length && t.scrollTop(g.position().top))
        };
        e.setRecordHistory = function(a, b) {
            S("recordHistory", a, b)
        };
        e.setScrollingSpeed = function(a, b) {
            S("scrollingSpeed", a, b)
        };
        e.setFitToSection = function(a, b) {
            S("fitToSection", a, b)
        };
        e.setLockAnchors = function(a) {
            d.lockAnchors = a
        };
        e.setMouseWheelScrolling = function(a) {
            a ? m.addEventListener ? (m.addEventListener("mousewheel", u, !1), m.addEventListener("wheel", u, !1), m.addEventListener("DOMMouseScroll", u, !1)) : m.attachEvent("onmousewheel", u) : m.addEventListener ? (m.removeEventListener("mousewheel", u, !1), m.removeEventListener("wheel", u, !1), m.removeEventListener("DOMMouseScroll", u, !1)) : m.detachEvent("onmousewheel", u)
        };
        e.setAllowScrolling = function(a, b) {
            "undefined" !== typeof b ? (b = b.replace(/ /g, "").split(","), c.each(b, function(b, c) {
                Ia(a, c, "m")
            })) : a ? (e.setMouseWheelScrolling(!0), Za()) : (e.setMouseWheelScrolling(!1), $a())
        };
        e.setKeyboardScrolling = function(a, b) {
            "undefined" !== typeof b ? (b = b.replace(/ /g, "").split(","), c.each(b, function(b, c) {
                Ia(a, c, "k")
            })) : d.keyboardScrolling = a
        };
        e.moveSectionUp = function() {
            var a = c(".fp-section.active").prev(".fp-section");
            a.length || !d.loopTop && !d.continuousVertical || (a = c(".fp-section").last());
            a.length && B(a, null, !0)
        };
        e.moveSectionDown = function() {
            var a = c(".fp-section.active").next(".fp-section");
            a.length || !d.loopBottom && !d.continuousVertical || (a = c(".fp-section").first());
            a.length && B(a, null, !1)
        };
        e.silentMoveTo = function(a, b) {
            requestAnimFrame(function() {
                e.setScrollingSpeed(0, "internal")
            });
            e.moveTo(a, b);
            requestAnimFrame(function() {
                e.setScrollingSpeed(G.scrollingSpeed, "internal")
            })
        };
        e.moveTo = function(a, b) {
            var c = Ea(a);
            "undefined" !== typeof b ? V(a, b) : 0 < c.length && B(c)
        };
        e.moveSlideRight = function() {
            ua("next")
        };
        e.moveSlideLeft = function() {
            ua("prev")
        };
        e.reBuild = function(a) {
            if (!h.hasClass("fp-destroyed")) {
                requestAnimFrame(function() {
                    v = !0
                });
                var b = n.width();
                q = n.height();
                d.resize && Ya(q, b);
                c(".fp-section").each(function() {
                    var a = c(this).find(".fp-slides"),
                        b = c(this).find(".fp-slide");
                    d.verticalCentered && c(this).find(".fp-tableCell").css("height", Da(c(this)) + "px");
                    c(this).css("height", q + "px");
                    d.scrollOverflow && (b.length ? b.each(function() {
                        J(c(this))
                    }) : J(c(this)));
                    1 < b.length && F(a, a.find(".fp-slide.active"))
                });
                (b = c(".fp-section.active").index(".fp-section")) && e.silentMoveTo(b + 1);
                requestAnimFrame(function() {
                    v = !1
                });
                c.isFunction(d.afterResize) && a && d.afterResize.call(h);
                c.isFunction(d.afterReBuild) && !a && d.afterReBuild.call(h)
            }
        };
        e.setResponsive = function(a) {
            var b = h.hasClass("fp-responsive");
            a ? b || (e.setAutoScrolling(!1, "internal"), e.setFitToSection(!1, "internal"), c("#fp-nav").hide(), h.addClass("fp-responsive")) : b && (e.setAutoScrolling(G.autoScrolling, "internal"), e.setFitToSection(G.autoScrolling, "internal"), c("#fp-nav").show(), h.removeClass("fp-responsive"))
        };
        var z = !1,
            Q = navigator.userAgent.match(/(iPhone|iPod|iPad|Android|playbook|silk|BlackBerry|BB10|Windows Phone|Tizen|Bada|webOS|IEMobile|Opera Mini)/),
            R = "ontouchstart" in l || 0 < navigator.msMaxTouchPoints || navigator.maxTouchPoints,
            h = c(this),
            q = n.height(),
            v = !1,
            Ja = !0,
            A, ea, y = !0,
            C = [],
            O, k = {
                m: {
                    up: !0,
                    down: !0,
                    left: !0,
                    right: !0
                }
            };
        k.k = c.extend(!0, {}, k.m);
        var G = c.extend(!0, {}, d),
            ha, ca, fa, Z, aa, Ka;
        c(this).length && La();
        var W = !1;
        n.on("scroll", oa);
        var E = 0,
            N = 0,
            D = 0,
            M = 0,
            ta = (new Date).getTime();
        l.requestAnimFrame = function() {
            return l.requestAnimationFrame || function(a) {
                a()
            }
        }();
        n.on("hashchange", xa);
        w.keydown(function(a) {
            clearTimeout(Ka);
            var b = c(":focus");
            b.is("textarea") || b.is("input") || b.is("select") || !d.keyboardScrolling || !d.autoScrolling || (-1 < c.inArray(a.which, [40, 38, 32, 33, 34]) && a.preventDefault(), O = a.ctrlKey, Ka = setTimeout(function() {
                var b = a.shiftKey;
                switch (a.which) {
                    case 38:
                    case 33:
                        k.k.up && e.moveSectionUp();
                        break;
                    case 32:
                        if (b && k.k.up) {
                            e.moveSectionUp();
                            break
                        }
                    case 40:
                    case 34:
                        k.k.down && e.moveSectionDown();
                        break;
                    case 36:
                        k.k.up && e.moveTo(1);
                        break;
                    case 35:
                        k.k.down && e.moveTo(c(".fp-section").length);
                        break;
                    case 37:
                        k.k.left && e.moveSlideLeft();
                        break;
                    case 39:
                        k.k.right && e.moveSlideRight()
                }
            }, 150))
        });
        w.keyup(function(a) {
            Ja && (O = a.ctrlKey)
        });
        c(l).blur(function() {
            O = Ja = !1
        });
        h.mousedown(function(a) {
            2 == a.which && (P = a.pageY, h.on("mousemove", Xa))
        });
        h.mouseup(function(a) {
            2 == a.which && h.off("mousemove")
        });
        var P = 0;
        w.on("click touchstart", "#fp-nav a", function(a) {
            a.preventDefault();
            a = c(this).parent().index();
            B(c(".fp-section").eq(a))
        });
        w.on("click touchstart", ".fp-slidesNav a", function(a) {
            a.preventDefault();
            a = c(this).closest(".fp-section").find(".fp-slides");
            var b = a.find(".fp-slide").eq(c(this).closest("li").index());
            F(a, b)
        });
        d.normalScrollElements && (w.on("mouseenter", d.normalScrollElements, function() {
            e.setMouseWheelScrolling(!1)
        }), w.on("mouseleave", d.normalScrollElements, function() {
            e.setMouseWheelScrolling(!0)
        }));
        c(".fp-section").on("click touchstart", ".fp-controlArrow", function() {
            c(this).hasClass("fp-prev") ? k.m.left && e.moveSlideLeft() : k.m.right && e.moveSlideRight()
        });
        n.resize(Ba);
        var ga = q;
        e.destroy = function(a) {
            e.setAutoScrolling(!1, "internal");
            e.setAllowScrolling(!1);
            e.setKeyboardScrolling(!1);
            h.addClass("fp-destroyed");
            clearTimeout(fa);
            clearTimeout(ca);
            clearTimeout(ha);
            clearTimeout(Z);
            clearTimeout(aa);
            n.off("scroll", oa).off("hashchange", xa).off("resize", Ba);
            w.off("click", "#fp-nav a").off("mouseenter", "#fp-nav li").off("mouseleave", "#fp-nav li").off("click", ".fp-slidesNav a").off("mouseover", d.normalScrollElements).off("mouseout", d.normalScrollElements);
            c(".fp-section").off("click", ".fp-controlArrow");
            clearTimeout(fa);
            clearTimeout(ca);
            a && ab()
        }
    }
});