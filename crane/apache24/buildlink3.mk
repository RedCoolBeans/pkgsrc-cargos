# $NetBSD: buildlink3.mk,v 1.8 2016/03/05 11:27:57 jperkin Exp $

BUILDLINK_TREE+=	apache

.if !defined(APACHE_BUILDLINK3_MK)
APACHE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.apache+=	apache>=2.4.7<2.5
BUILDLINK_ABI_DEPENDS.apache+=	apache>=2.4.18nb1
BUILDLINK_PKGSRCDIR.apache?=	../../crane/apache24
BUILDLINK_DEPMETHOD.apache?=	build
.if defined(APACHE_MODULE)
BUILDLINK_DEPMETHOD.apache+=	full
.endif

BUILDLINK_FILES.apache+=	sbin/apxs
${BUILDLINK_DIR}/bin/apxs: buildlink-directories
	${MKDIR} ${BUILDLINK_DIR}/bin && ${LN} -fs ../sbin/apxs ${BUILDLINK_DIR}/bin/apxs

buildlink-apache-cookie: ${BUILDLINK_DIR}/bin/apxs

USE_TOOLS+=	perl			# for "apxs"
CONFIGURE_ENV+=	APR_LIBTOOL=${LIBTOOL:Q}	# make apxs use the libtool we specify
MAKE_ENV+=	APR_LIBTOOL=${LIBTOOL:Q}
APXS?=		${BUILDLINK_PREFIX.apache}/bin/apxs
.if defined(GNU_CONFIGURE)
CONFIGURE_ARGS+=	--with-apxs2=${APXS:Q}
.endif

.include "../../crane/apr/buildlink3.mk"
.include "../../crane/apr-util/buildlink3.mk"
.endif # APACHE_BUILDLINK3_MK

BUILDLINK_TREE+=	-apache
